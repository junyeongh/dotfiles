#!/usr/bin/env bash
input=$(cat)

# ANSI color codes
BLACK='\033[38;5;0m'
RED='\033[38;5;1m'
GREEN='\033[38;5;2m'
YELLOW='\033[38;5;3m'
BLUE='\033[38;5;4m'
MAGENTA='\033[38;5;5m'
CYAN='\033[38;5;6m'
WHITE='\033[38;5;7m'
GRAY='\033[38;5;8m'
BRIGHT_RED='\033[38;5;9m'
BRIGHT_GREEN='\033[38;5;10m'
BRIGHT_YELLOW='\033[38;5;11m'
BRIGHT_BLUE='\033[38;5;12m'
BRIGHT_MAGENTA='\033[38;5;13m'
BRIGHT_CYAN='\033[38;5;14m'
BRIGHT_WHITE='\033[38;5;15m'

# Claude brand orange (#D97757), 24-bit with a 256-color fallback
if [[ "$COLORTERM" == truecolor || "$COLORTERM" == 24bit ]]; then
  CLAUDE_ORANGE='\033[38;2;217;119;87m'
else
  CLAUDE_ORANGE='\033[38;5;173m'
fi

RESET='\033[0m'

# Get terminal width
term_width=$(tput cols 2>/dev/null || echo 80)

# Helper functions for common extractions
get_context_window_size() { echo "$input" | jq -r '.context_window.context_window_size // 0'; }
get_current_dir() { echo "$input" | jq -r '.workspace.current_dir // empty'; }
get_effort_level() { echo "$input" | jq -r '.effort.level // empty'; }
get_model_display_name() { echo "$input" | jq -r '.model.display_name // "Claude"'; }
get_project_dir() { echo "$input" | jq -r '.workspace.project_dir // empty'; }
get_thinking_enabled() { echo "$input" | jq -r 'if .thinking.enabled then "1" else empty end'; }
get_total_cost_usd() { echo "$input" | jq -r '.cost.total_cost_usd // 0'; }
get_total_duration_ms() { echo "$input" | jq -r '.cost.total_duration_ms // 0'; }
get_total_input_tokens() { echo "$input" | jq -r '.context_window.total_input_tokens // 0'; }
get_total_lines_added() { echo "$input" | jq -r '.cost.total_lines_added // 0'; }
get_total_lines_removed() { echo "$input" | jq -r '.cost.total_lines_removed // 0'; }
get_total_output_tokens() { echo "$input" | jq -r '.context_window.total_output_tokens // 0'; }
get_version() { echo "$input" | jq -r '.version // empty'; }

# Use the helpers
CONTEXT_WINDOW_SIZE=$(get_context_window_size)
CURRENT_DIR=$(get_current_dir)
EFFORT_LEVEL=$(get_effort_level)
MODEL_DISPLAY_NAME=$(get_model_display_name)
PROJECT_DIR=$(get_project_dir)
THINKING_ENABLED=$(get_thinking_enabled)
TOTAL_COST_USD=$(get_total_cost_usd)
TOTAL_DURATION_MS=$(get_total_duration_ms)
TOTAL_INPUT_TOKENS=$(get_total_input_tokens)
TOTAL_LINES_ADDED=$(get_total_lines_added)
TOTAL_LINES_REMOVED=$(get_total_lines_removed)
TOTAL_OUTPUT_TOKENS=$(get_total_output_tokens)
VERSION=$(get_version)

[ -n "$CURRENT_DIR" ] || CURRENT_DIR=$PWD

# Get git branch using $CURRENT_DIR as the working directory
get_git_branch() {
  if git -C "$CURRENT_DIR" rev-parse --git-dir >/dev/null 2>&1; then
    git -C "$CURRENT_DIR" -c core.fileMode=false branch --show-current 2>/dev/null ||
      git -C "$CURRENT_DIR" rev-parse --short HEAD 2>/dev/null
  fi
}

USERNAME=$(whoami)

GIT_BRANCH=$(get_git_branch)

progress_bar() {
  pct="${1:-0}"
  width="${2:-10}"
  [[ "$pct" =~ ^[0-9]+$ ]] || pct=0
  ((pct < 0)) && pct=0
  ((pct > 100)) && pct=100
  filled=$((pct * width / 100))
  empty=$((width - filled))
  printf '%*s' "$filled" '' | tr ' ' '='
  printf '%*s' "$empty" '' | tr ' ' '-'
}

format_number() {
  local n="$1" result=""
  while [ ${#n} -gt 3 ]; do
    result=",${n: -3}${result}"
    n="${n:0:${#n}-3}"
  done
  echo "${n}${result}"
}

format_reset() {
  local epoch="$1" fmt="$2"
  [ -n "$epoch" ] && [ "$epoch" != "null" ] && date -d "@$epoch" +"$fmt" 2>/dev/null
}

# label, used_percentage, resets_at (epoch), date format for the reset time
rate_limit_segment() {
  local label="$1" pct_raw="$2" reset_epoch="$3" fmt="$4"
  [ -z "$pct_raw" ] && return
  local pct=$(printf '%.0f' "$pct_raw")
  local color="$GREEN"
  if ((pct >= 90)); then
    color="$BRIGHT_RED"
  elif ((pct >= 70)); then
    color="$BRIGHT_YELLOW"
  fi
  local reset=$(format_reset "$reset_epoch" "$fmt")
  printf '%b' "${GRAY}${label}${RESET} ${color}${pct}%${RESET} [$(progress_bar "$pct" 8)]${reset:+ ${GRAY}(${reset})${RESET}} "
}

# Build output
output=""
output="${output}${GREEN}(v${VERSION})${RESET} "
output="${output}${CYAN}${CURRENT_DIR}${RESET} "

if [ -n "$GIT_BRANCH" ]; then
  output="${output}${RED}:: ${GIT_BRANCH}${RESET} "
fi

output="${output}${CLAUDE_ORANGE}${MODEL_DISPLAY_NAME}${RESET}"
[ -n "$EFFORT_LEVEL" ] && output="${output} ${CLAUDE_ORANGE}${EFFORT_LEVEL}${RESET}"
[ -n "$THINKING_ENABLED" ] && output="${output} ${CLAUDE_ORANGE}(thinking)${RESET}"
output="${output}\n"

output="${output}${BRIGHT_YELLOW}\$$(printf '%.3f' "$TOTAL_COST_USD")${RESET} "

if [ "$TOTAL_LINES_ADDED" != "0" ] || [ "$TOTAL_LINES_REMOVED" != "0" ]; then
  output="${output}("
  [ "$TOTAL_LINES_ADDED" != "0" ] && output="${output}${BRIGHT_GREEN}+${TOTAL_LINES_ADDED}${RESET}"
  [ "$TOTAL_LINES_ADDED" != "0" ] && [ "$TOTAL_LINES_REMOVED" != "0" ] && output="${output}, "
  [ "$TOTAL_LINES_REMOVED" != "0" ] && output="${output}${BRIGHT_RED}-${TOTAL_LINES_REMOVED}${RESET}"
  output="${output}) "
fi

USAGE=$(echo "$input" | jq '.context_window.current_usage')
if [ "$USAGE" != "null" ] && [ "$CONTEXT_WINDOW_SIZE" -gt 0 ]; then
  # Calculate current context from current_usage fields
  CURRENT_TOKENS=$(echo "$USAGE" | jq '(.input_tokens // 0) + (.cache_creation_input_tokens // 0) + (.cache_read_input_tokens // 0)')
  PERCENT_USED=$((CURRENT_TOKENS * 100 / CONTEXT_WINDOW_SIZE))
  output="${output}$(format_number "$CURRENT_TOKENS")/$(format_number "$CONTEXT_WINDOW_SIZE") ($PERCENT_USED%) "
fi

# Subscription rate limits: only present for Claude.ai Pro/Max (or a spend-limit
# gateway), and only after the first API response. "// empty" handles absence.
FIVE_HOUR_PCT=$(echo "$input" | jq -r '.rate_limits.five_hour.used_percentage // empty')
FIVE_HOUR_RESET=$(echo "$input" | jq -r '.rate_limits.five_hour.resets_at // empty')
SEVEN_DAY_PCT=$(echo "$input" | jq -r '.rate_limits.seven_day.used_percentage // empty')
SEVEN_DAY_RESET=$(echo "$input" | jq -r '.rate_limits.seven_day.resets_at // empty')
SPEND_LIMIT_PCT=$(echo "$input" | jq -r '.rate_limits.spend_limit.used_percentage // empty')
SPEND_LIMIT_RESET=$(echo "$input" | jq -r '.rate_limits.spend_limit.resets_at // empty')

LIMITS=""
LIMITS="${LIMITS}$(rate_limit_segment '5h' "$FIVE_HOUR_PCT" "$FIVE_HOUR_RESET" '%H:%M')"
LIMITS="${LIMITS}$(rate_limit_segment '7d' "$SEVEN_DAY_PCT" "$SEVEN_DAY_RESET" '%a %H:%M')"
LIMITS="${LIMITS}$(rate_limit_segment '$' "$SPEND_LIMIT_PCT" "$SPEND_LIMIT_RESET" '%b %-d')"

output="${output}${LIMITS% }"

# Output the final line
printf "%b\n" "$output"
