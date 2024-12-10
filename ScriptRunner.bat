@echo off
setlocal enabledelayedexpansion

set LOGFILE=Log.txt
set "startTime=%time%"
set "startDate=%date%"

:: this is to start with a completly empty Log file each time 
type nul > %LOGFILE%

call :log_message "!date! !time! Starting Running Scripts"

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
exit /b 0

:log_message
echo %~1
echo %~1 >> %LOGFILE%
goto :eof