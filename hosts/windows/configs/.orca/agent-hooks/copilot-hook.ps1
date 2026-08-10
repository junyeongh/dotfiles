Write-Output '{}'
$inputData = [Console]::In.ReadToEnd()
if ($env:ORCA_AGENT_HOOK_ENDPOINT -and (Test-Path -LiteralPath $env:ORCA_AGENT_HOOK_ENDPOINT)) {
  try {
    Get-Content -LiteralPath $env:ORCA_AGENT_HOOK_ENDPOINT | ForEach-Object {
      if ($_ -match '^set ([A-Za-z0-9_]+)=(.*)$') {
        [Environment]::SetEnvironmentVariable($matches[1], $matches[2], 'Process')
      }
    }
  } catch {}
}
if (-not $env:ORCA_AGENT_HOOK_PORT -or -not $env:ORCA_AGENT_HOOK_TOKEN -or -not $env:ORCA_PANE_KEY) { exit 0 }
if ([string]::IsNullOrWhiteSpace($inputData)) { exit 0 }
try {
  $payload = $inputData | ConvertFrom-Json
  $body = @{
    paneKey = $env:ORCA_PANE_KEY
    launchToken = $env:ORCA_AGENT_LAUNCH_TOKEN
    tabId = $env:ORCA_TAB_ID
    worktreeId = $env:ORCA_WORKTREE_ID
    hookEventName = $env:ORCA_COPILOT_HOOK_EVENT
    env = $env:ORCA_AGENT_HOOK_ENV
    version = $env:ORCA_AGENT_HOOK_VERSION
    payload = $payload
  } | ConvertTo-Json -Depth 100
  Invoke-WebRequest -UseBasicParsing -Method Post -Uri ('http://127.0.0.1:' + $env:ORCA_AGENT_HOOK_PORT + '/hook/copilot') -Headers @{ 'Content-Type'='application/json'; 'X-Orca-Agent-Hook-Token'=$env:ORCA_AGENT_HOOK_TOKEN } -Body $body -TimeoutSec 2 | Out-Null
} catch {}
exit 0
