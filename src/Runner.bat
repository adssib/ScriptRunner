@echo off 
setlocal enabledelayedexpansion

:: Define a newline character 
set "newline=\n" 

:: Initialize list of successful scripts 
set "successList=" 

if not exist "FilesToRun.txt" ( 
    echo FilesToRun.txt not found! pause exit /b 1 
) 
    
:: === Main Loop === 
for /F "usebackq delims=" %%i in ("FilesToRun.txt") do ( 
    call :sendEmail "smth.smthElse@outlook.com" "Started running %%i" "Script Started" 
    call "%~dp0%%i" 
    if errorlevel 1 ( 
        call :sendEmail "smth.smthElse@outlook.com" "Script %%i failed during execution" "Error Occurred" 
        echo ======================================== 
        echo %%i Failed 
        echo ======================================== 
        exit /b 1 
    )

    echo === Batch Script Finished successfully === 
    set "successList=!successList!%%i!newline!" 
    call :sendEmail "smth.smthElse@outlook.com" "Started finished %%i" "Script finished" 
) 

:: === All done === 
echo ======================================== 
echo All Scripts completed 
echo ======================================== 

type "FilesToRun.txt" 
set "finalBody=All scripts finished successfully. The following scripts were successfully executed:!newline!!successList!" 

call :sendEmail "smth.smthElse@outlook.com" "!finalBody!" "Done" 
goto :eof 

:sendEmail powershell -ExecutionPolicy Bypass -File "%~dp0sendEmail.ps1" -email "%~1" -body "%~2" -subject "%~3" 
goto :eof