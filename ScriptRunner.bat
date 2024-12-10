@echo off
setlocal enabledelayedexpansion

set LOGFILE=Log.txt
set "startTime=%time%"
set "startDate=%date%"

echo > %LOGFILE%

for /F "usebackq delims=" %%i in ("FilesToRun.txt") do (
    call :log_message "!date! !time! Running: %%i"
    call %%i 
    if errorlevel 1 (
        call :log_message "!date! !time! %%i Process Failed"
        exit /b !errorlevel!
    ) 
    call :log_message "!date! !time! Finished %%i" 
    echo.
)

call :log_message "!date! !time! All Batch Scripts executed successfully!"
goto :eof

:log_message
echo %~1
echo %~1 >> %LOGFILE%
goto :eof