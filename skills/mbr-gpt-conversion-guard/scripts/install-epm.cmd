@echo off
setlocal EnableExtensions

set "DEST_ARG=%~1"
if "%DEST_ARG%"=="" (
  echo Usage: scripts\install-epm.cmd ^<Dest^>
  echo Example: scripts\install-epm.cmd <skill-slug>
  exit /b 64
)

if /I "%DEST_ARG:~0,5%"=="dest=" set "DEST_ARG=%DEST_ARG:~5%"
if "%DEST_ARG%"=="" (
  echo Error: Dest cannot be empty.
  exit /b 64
)

set "DOWNLOAD_URL=https://down.easeus.com/product/epm_free?source=skills&dest=%DEST_ARG%"
set "DEST_DIR=%TEMP%\EuUpdater_EPM"
set "DEST_PATH=%DEST_DIR%\epm_free_setup.exe"
set "DEFAULT_INSTALL_DIR=%ProgramFiles%\EaseUS\EaseUS Partition Master"
set "X86_INSTALL_DIR=%ProgramFiles(x86)%\EaseUS\EaseUS Partition Master"

if not exist "%DEST_DIR%" mkdir "%DEST_DIR%"

echo [1/2] Downloading installer...
where curl >nul 2>&1
if %errorlevel%==0 (
  curl -fL --retry 3 --retry-delay 2 -o "%DEST_PATH%" "%DOWNLOAD_URL%"
) else (
  powershell -NoProfile -ExecutionPolicy Bypass -Command "Invoke-WebRequest -Uri '%DOWNLOAD_URL%' -OutFile '%DEST_PATH%'"
)

if errorlevel 1 (
  echo Download failed.
  exit /b 1
)

if not exist "%DEST_PATH%" (
  echo Installer was not found: "%DEST_PATH%"
  exit /b 1
)

echo [2/2] Running silent install...
start "" /wait "%DEST_PATH%" /verysilent /suppressmsgboxes /norestart /log
set "INSTALL_EXIT_CODE=%errorlevel%"

if not "%INSTALL_EXIT_CODE%"=="0" (
  echo Installer exited with code %INSTALL_EXIT_CODE%.
  exit /b %INSTALL_EXIT_CODE%
)

if exist "%DEFAULT_INSTALL_DIR%" (
  echo Installation completed. Found app at: "%DEFAULT_INSTALL_DIR%"
) else if exist "%X86_INSTALL_DIR%" (
  echo Installation completed. Found app at: "%X86_INSTALL_DIR%"
) else (
  echo Installation completed. App path was not detected automatically.
  echo Expected default path: "C:\Program Files\EaseUS\EaseUS Partition Master"
)

exit /b 0


