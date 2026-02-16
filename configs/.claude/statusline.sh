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

RESET='\033[0m'

# Get terminal width
term_width=$(tput cols 2>/dev/null || echo 80)

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

# Helper functions for common extractions
get_context_window_size() { echo "$input" | jq -r '.context_window.context_window_size'; }
get_current_dir() { echo "$input" | jq -r '.workspace.current_dir'; }
get_model_display_name() { echo "$input" | jq -r '.model.display_name'; }
get_project_dir() { echo "$input" | jq -r '.workspace.project_dir'; }
get_total_cost_usd() { echo "$input" | jq -r '.cost.total_cost_usd'; }
get_total_duration_ms() { echo "$input" | jq -r '.cost.total_duration_ms'; }
get_total_input_tokens() { echo "$input" | jq -r '.context_window.total_input_tokens'; }
get_total_lines_added() { echo "$input" | jq -r '.cost.total_lines_added'; }
get_total_lines_removed() { echo "$input" | jq -r '.cost.total_lines_removed'; }
get_total_output_tokens() { echo "$input" | jq -r '.context_window.total_output_tokens'; }
get_version() { echo "$input" | jq -r '.version'; }
get_output_style() { echo "$input" | jq -r '.output_style.name'; }

# Use the helpers
CONTEXT_WINDOW_SIZE=$(get_context_window_size)
CURRENT_DIR=$(get_current_dir)
MODEL_DISPLAY_NAME=$(get_model_display_name)
OUTPUT_STYLE=$(get_output_style)
PROJECT_DIR=$(get_project_dir)
TOTAL_COST_USD=$(get_total_cost_usd)
TOTAL_DURATION_MS=$(get_total_duration_ms)
TOTAL_INPUT_TOKENS=$(get_total_input_tokens)
TOTAL_LINES_ADDED=$(get_total_lines_added)
TOTAL_LINES_REMOVED=$(get_total_lines_removed)
TOTAL_OUTPUT_TOKENS=$(get_total_output_tokens)
VERSION=$(get_version)

get_git_branch() {
  if git rev-parse --git-dir >/dev/null 2>&1; then
    echo $(git -c core.fileMode=false branch --show-current 2>/dev/null || git rev-parse --short HEAD 2>/dev/null)
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

# Build output
output=""
output="${output}${GREEN}(v${VERSION})${RESET} "
output="${output}${CYAN}${CURRENT_DIR}${RESET} "

if [ -n "$GIT_BRANCH" ]; then
  output="${output}${RED}:: ${GIT}${GIT_BRANCH}${RESET}\n"
else
  output="${output}\n"
fi

output="${output}${MODEL_DISPLAY_NAME} (${OUTPUT_STYLE})${RESET} "
output="${output}${BRIGHT_YELLOW}\$$(printf '%.3f' $TOTAL_COST_USD)${RESET} "

if [ "$TOTAL_LINES_ADDED" != "0" ] || [ "$TOTAL_LINES_REMOVED" != "0" ]; then
  output="${output}("
  [ "$TOTAL_LINES_ADDED" != "0" ] && output="${output}${BRIGHT_GREEN}+${TOTAL_LINES_ADDED}${RESET}"
  [ "$TOTAL_LINES_ADDED" != "0" ] && [ "$TOTAL_LINES_REMOVED" != "0" ] && output="${output}, "
  [ "$TOTAL_LINES_REMOVED" != "0" ] && output="${output}${BRIGHT_RED}-${TOTAL_LINES_REMOVED}${RESET}"
  output="${output}) "
fi

USAGE=$(echo "$input" | jq '.context_window.current_usage')
if [ "$USAGE" != "null" ]; then
  # Calculate current context from current_usage fields
  CURRENT_TOKENS=$(echo "$USAGE" | jq '.input_tokens + .cache_creation_input_tokens + .cache_read_input_tokens')
  PERCENT_USED=$((CURRENT_TOKENS * 100 / CONTEXT_WINDOW_SIZE))
  output="${output}$CURRENT_TOKENS/$CONTEXT_WINDOW_SIZE ($PERCENT_USED%) "
  output="${output}[$(progress_bar "$PERCENT_USED" 10)] "
fi

# Output the final line
printf "%b\n" "$output"
