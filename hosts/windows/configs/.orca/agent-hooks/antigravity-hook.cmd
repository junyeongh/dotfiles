@echo off
setlocal
if /I "%ORCA_ANTIGRAVITY_EVENT%"=="Stop" (
  echo {"decision":""}
) else (
  echo {}
)
if defined ORCA_AGENT_HOOK_ENDPOINT if exist "%ORCA_AGENT_HOOK_ENDPOINT%" call "%ORCA_AGENT_HOOK_ENDPOINT%" 2>nul
if "%ORCA_AGENT_HOOK_PORT%"=="" goto :orca_agent_hook_drain_stdin
if "%ORCA_AGENT_HOOK_TOKEN%"=="" goto :orca_agent_hook_drain_stdin
if "%ORCA_PANE_KEY%"=="" goto :orca_agent_hook_drain_stdin
"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -ExecutionPolicy Bypass -Command "$utf8=[System.Text.UTF8Encoding]::new($false); [Console]::InputEncoding=$utf8; [Console]::OutputEncoding=$utf8; $inputData=[Console]::In.ReadToEnd(); try { $payload=if ([string]::IsNullOrWhiteSpace($inputData)) { @{} } else { $inputData | ConvertFrom-Json }; $body=@{ paneKey=$env:ORCA_PANE_KEY; launchToken=$env:ORCA_AGENT_LAUNCH_TOKEN; tabId=$env:ORCA_TAB_ID; worktreeId=$env:ORCA_WORKTREE_ID; env=$env:ORCA_AGENT_HOOK_ENV; version=$env:ORCA_AGENT_HOOK_VERSION; hook_event_name=$env:ORCA_ANTIGRAVITY_EVENT; payload=$payload } | ConvertTo-Json -Depth 100 -Compress; $bodyBytes=$utf8.GetBytes($body); Invoke-WebRequest -UseBasicParsing -Method Post -Uri ('http://127.0.0.1:' + $env:ORCA_AGENT_HOOK_PORT + '/hook/antigravity') -ContentType 'application/json; charset=utf-8' -Headers @{ 'X-Orca-Agent-Hook-Token'=$env:ORCA_AGENT_HOOK_TOKEN } -Body $bodyBytes -TimeoutSec 2 | Out-Null } catch {}"
exit /b 0
:orca_agent_hook_drain_stdin
"%SystemRoot%\System32\more.com" >nul 2>nul
exit /b 0
