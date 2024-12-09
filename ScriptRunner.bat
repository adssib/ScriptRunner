@echo off
setlocal enabledelayedexpansion

set LOGFILE=Log.txt

for /F "usebackq delims=" %%i in ("FilesToRun.txt") do (
    echo Running: %%i 
    call %%i 
    if errorlevel 1 (
        echo %%i Process Failed 
        exit /b !errorlevel!
    ) 
    echo Finished Running %%i 
    echo.
)

echo All Batch Script are executed successfully!