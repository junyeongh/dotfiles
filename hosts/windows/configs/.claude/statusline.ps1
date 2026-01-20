# Claude Code statusline - PowerShell version
param()

# Set PowerShell output encoding to UTF-8
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

# ANSI color codes
$BLACK = "$([char]27)[38;5;0m"
$RED = "$([char]27)[38;5;1m"
$GREEN = "$([char]27)[38;5;2m"
$YELLOW = "$([char]27)[38;5;3m"
$BLUE = "$([char]27)[38;5;4m"
$MAGENTA = "$([char]27)[38;5;5m"
$CYAN = "$([char]27)[38;5;6m"
$WHITE = "$([char]27)[38;5;7m"
$GRAY = "$([char]27)[38;5;8m"
$BRIGHT_RED = "$([char]27)[38;5;9m"
$BRIGHT_GREEN = "$([char]27)[38;5;10m"
$BRIGHT_YELLOW = "$([char]27)[38;5;11m"
$BRIGHT_BLUE = "$([char]27)[38;5;12m"
$BRIGHT_MAGENTA = "$([char]27)[38;5;13m"
$BRIGHT_CYAN = "$([char]27)[38;5;14m"
$BRIGHT_WHITE = "$([char]27)[38;5;15m"

$RESET = "$([char]27)[0m"

# Progress bar function
function Get-ProgressBar {
    param(
        [int]$Percent = 0,
        [int]$Width = 10
    )

    if ($Percent -lt 0) { $Percent = 0 }
    if ($Percent -gt 100) { $Percent = 100 }

    $filled = [math]::Floor($Percent * $Width / 100)
    $empty = $Width - $filled

    return ('=' * $filled) + ('-' * $empty)
}

# Read JSON input from stdin
$jsonInput = ""
try {
    $inputStream = [System.IO.StreamReader]::new([System.Console]::OpenStandardInput())
    $jsonInput = $inputStream.ReadToEnd()
    $inputStream.Close()
}
catch {
    $jsonInput = '{}'
}

# Parse JSON and extract data
try {
    $inputData = $jsonInput | ConvertFrom-Json

    $CONTEXT_WINDOW_SIZE = if ($inputData.context_window.context_window_size) { $inputData.context_window.context_window_size } else { 0 }
    $CURRENT_DIR = if ($inputData.workspace.current_dir) { $inputData.workspace.current_dir } else { $pwd.Path }
    $MODEL_DISPLAY_NAME = if ($inputData.model.display_name) { $inputData.model.display_name } else { "Claude" }
    $OUTPUT_STYLE = if ($inputData.output_style.name) { $inputData.output_style.name } else { "" }
    $PROJECT_DIR = if ($inputData.workspace.project_dir) { $inputData.workspace.project_dir } else { "" }
    $TOTAL_COST_USD = if ($inputData.cost.total_cost_usd) { $inputData.cost.total_cost_usd } else { 0 }
    $TOTAL_DURATION_MS = if ($inputData.cost.total_duration_ms) { $inputData.cost.total_duration_ms } else { 0 }
    $TOTAL_INPUT_TOKENS = if ($inputData.context_window.total_input_tokens) { $inputData.context_window.total_input_tokens } else { 0 }
    $TOTAL_LINES_ADDED = if ($inputData.cost.total_lines_added) { $inputData.cost.total_lines_added } else { 0 }
    $TOTAL_LINES_REMOVED = if ($inputData.cost.total_lines_removed) { $inputData.cost.total_lines_removed } else { 0 }
    $TOTAL_OUTPUT_TOKENS = if ($inputData.context_window.total_output_tokens) { $inputData.context_window.total_output_tokens } else { 0 }
    $VERSION = if ($inputData.version) { $inputData.version } else { "" }
    $CURRENT_USAGE = $inputData.context_window.current_usage
}
catch {
    $CONTEXT_WINDOW_SIZE = 0
    $CURRENT_DIR = $pwd.Path
    $MODEL_DISPLAY_NAME = "Claude"
    $OUTPUT_STYLE = ""
    $PROJECT_DIR = ""
    $TOTAL_COST_USD = 0
    $TOTAL_DURATION_MS = 0
    $TOTAL_INPUT_TOKENS = 0
    $TOTAL_LINES_ADDED = 0
    $TOTAL_LINES_REMOVED = 0
    $TOTAL_OUTPUT_TOKENS = 0
    $VERSION = ""
    $CURRENT_USAGE = $null
}

# Get git branch
$GIT_BRANCH = ""
try {
    if (Test-Path ".git") {
        $GIT_BRANCH = & git -c core.fileMode=false branch --show-current 2>$null
        if (-not $GIT_BRANCH) {
            $GIT_BRANCH = & git rev-parse --short HEAD 2>$null
        }
    }
}
catch {
    $GIT_BRANCH = ""
}

$USERNAME = $env:USERNAME

# Build output
$output = ""
$output += "${GREEN}(v${VERSION})${RESET} "
$output += "${CYAN}${CURRENT_DIR}${RESET} "

if ($GIT_BRANCH) {
    $output += "${RED}:: ${GIT_BRANCH}${RESET}`n"
} else {
    $output += "`n"
}

$output += "${MODEL_DISPLAY_NAME} (${OUTPUT_STYLE})${RESET} "
$output += "${BRIGHT_YELLOW}`$$($TOTAL_COST_USD.ToString('0.000'))${RESET} "

if ($TOTAL_LINES_ADDED -ne 0 -or $TOTAL_LINES_REMOVED -ne 0) {
    $output += "("
    if ($TOTAL_LINES_ADDED -ne 0) {
        $output += "${BRIGHT_GREEN}+${TOTAL_LINES_ADDED}${RESET}"
    }
    if ($TOTAL_LINES_ADDED -ne 0 -and $TOTAL_LINES_REMOVED -ne 0) {
        $output += ", "
    }
    if ($TOTAL_LINES_REMOVED -ne 0) {
        $output += "${BRIGHT_RED}-${TOTAL_LINES_REMOVED}${RESET}"
    }
    $output += ") "
}

if ($CURRENT_USAGE) {
    # Calculate current context from current_usage fields
    $input_tokens = if ($CURRENT_USAGE.input_tokens) { $CURRENT_USAGE.input_tokens } else { 0 }
    $cache_creation = if ($CURRENT_USAGE.cache_creation_input_tokens) { $CURRENT_USAGE.cache_creation_input_tokens } else { 0 }
    $cache_read = if ($CURRENT_USAGE.cache_read_input_tokens) { $CURRENT_USAGE.cache_read_input_tokens } else { 0 }

    $CURRENT_TOKENS = $input_tokens + $cache_creation + $cache_read
    $PERCENT_USED = [math]::Floor($CURRENT_TOKENS * 100 / $CONTEXT_WINDOW_SIZE)
    $output += "$CURRENT_TOKENS/$CONTEXT_WINDOW_SIZE ($PERCENT_USED%) "
    $output += "[$(Get-ProgressBar -Percent $PERCENT_USED -Width 10)] "
}

# Output the final line
Write-Host $output

exit 0
