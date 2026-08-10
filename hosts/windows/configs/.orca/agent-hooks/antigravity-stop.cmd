@echo off
setlocal
set "ORCA_ANTIGRAVITY_EVENT=Stop"
set "ORCA_ANTIGRAVITY_CORE=%~dp0antigravity-hook.cmd"
if exist "%ORCA_ANTIGRAVITY_CORE%" (
  call "%ORCA_ANTIGRAVITY_CORE%"
  exit /b 0
)
if /I "%ORCA_ANTIGRAVITY_EVENT%"=="Stop" (
  echo {"decision":""}
) else (
  echo {}
)
"%SystemRoot%\System32\more.com" >nul 2>nul
exit /b 0
