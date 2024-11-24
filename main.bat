@echo off
setlocal EnableDelayedExpansion
chcp 65001 >nul
echo.
echo.
echo.
echo.
echo  _____                     _ _ _      _____ _      _____ 
echo ^|  __ \                   ^| ^(_) ^|    / ____^| ^|    ^|_   _^|
echo ^| ^|__) ^|___  __ _  ___  __^| ^_^| ^_^  ^| ^|    ^| ^|      ^| ^|  
echo ^|  _  // _ \/ _` ^|/ _ \/ _` ^| ^| __^| ^| ^|    ^| ^|      ^| ^|  
echo ^| ^| \ \  __/ (_^| ^|  __/ (_^| ^| ^| ^_^  ^| ^|____^| ^|____ _^| ^|_ 
echo ^|_^|  \_\___^\__, ^|\___^\__,_^|_^\\__^|  ^|\_____^|______^|_____^|
echo              __/ ^|                                       
echo             ^|___/                                         ██████  ███████ ████████  █████  ██
echo                                                           ██   ██ ██         ██    ██   ██ ██
echo                                                           ██████  █████      ██    ███████ ██
echo                                                           ██   ██ ██         ██    ██   ██ 
echo                                                           ██████  ███████    ██    ██   ██ ██    
echo.                                      

:: Display menu
echo Choose an option:
echo [1] Export Registry hive (or whole) to a file
echo [2] Restore Registry from a file
echo [0] Exit
set /p "choice=Enter your choice: "

:: Handle user input
if "%choice%"=="1" goto export_registry
if "%choice%"=="2" goto restore_registry
if "%choice%"=="0" goto exit
echo Invalid choice! Please try again.
pause
goto :eof

:export_registry
cls
echo Exporting registry...
echo Enter the name of export file:
set /p "name=Filename: "
echo Enter the registry hive or key to export (e.g., HKLM\Software):
set /p "hive=Registry Hive or Key: "
echo Enter the full file path (including name) to save the export:
set /p "file_path=Full File Path: "
if %name%=="" (
    echo Filename cannot be empty!
    pause
    goto :eof
)
if "%hive%"=="" (
    echo Registry hive or key cannot be empty!
    pause
    goto :eof
)
if "%path%"=="" (
    set "path=%CD%\%name%.reg"
    echo No file path provided. Exporting to "%path%".
)

echo Exporting "%hive%" to "%path%"...
reg export "%hive%" "%path%" /y
if errorlevel 1 (
    echo Failed to export the registry! Please check your inputs.
) else (
    echo Export successful! File saved as "%path%".
)
pause
goto :eof

:restore_registry
cls
echo Enter the name of the file to restore from:
set /p "name=Filename: "
if not exist "%name%" (
    echo File not found!
    pause
    goto :eof
)
echo Restoring registry from "%name%"...
reg import "%name%"
if errorlevel 1 (
    echo Failed to restore the registry! Please check the file.
) else (
    echo Restore complete!
)
pause
goto :eof

:exit
echo Exiting...
pause

