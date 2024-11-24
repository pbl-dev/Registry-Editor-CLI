@echo off
setlocal EnableDelayedExpansion

:: Set read-only mode
set READ_ONLY=1

:: Display ASCII Art
echo .
echo .
echo .
echo .
echo  _____                     _ _ _      _____ _      _____ 
echo ^|  __ \                   ^| ^(_) ^|    / ____^| ^|    ^|_   _^|
echo ^| ^|__) ^|___  __ _  ___  __^| ^_^| ^_^  ^| ^|    ^| ^|      ^| ^|  
echo ^|  _  // _ \/ _` ^|/ _ \/ _` ^| ^| __^| ^| ^|    ^| ^|      ^| ^|  
echo ^| ^| \ \  __/ (_^| ^|  __/ (_^| ^| ^| ^_^  ^| ^|____^| ^|____ _^| ^|_ 
echo ^|_^|  \_\___^\__, ^|\___^\__,_^|_^\\__^|  ^|\_____^|______^|_____^|
echo              __/ ^|                                       
echo             ^|___/                                        
echo .
echo .
echo .

:: Display menu options
echo Choose an option:
echo [1] Backup Registry
echo [2] Restore Registry
echo [3] Edit Registry
echo [4] Exit
set /p "choice=Enter your choice: "

:: Handle user input
if "%choice%"=="1" goto backup_registry
if "%choice%"=="2" goto restore_registry
if "%choice%"=="3" goto edit_registry
if "%choice%"=="4" goto exit
echo Invalid choice! Please try again.
pause
goto :eof

:: Option 1: Backup Registry
:backup_registry
if "%READ_ONLY%"=="1" (
    echo Read-only mode is enabled. No changes will be made.
) else (
    echo Backing up registry...
    reg export HKLM\Software backup.reg /y
    echo Backup complete! File saved as backup.reg
)
pause
goto :eof

:: Option 2: Restore Registry
:restore_registry
if "%READ_ONLY%"=="1" (
    echo Read-only mode is enabled. No changes will be made.
) else (
    echo Restoring registry...
    reg import backup.reg
    echo Restore complete!
)
pause
goto :eof

:: Option 3: Edit Registry
:edit_registry
echo Choose an option:
echo [1] Open specific key
echo [2] Open specific hive
echo [3] Open Registry Editor
echo [4] Go back to main menu
set /p "edit_choice=Enter your choice: "

if "%edit_choice%"=="1" goto open_key
if "%edit_choice%"=="2" goto open_hive
if "%edit_choice%"=="3" goto open_regedit
if "%edit_choice%"=="4" goto main_menu
echo Invalid choice! Please try again.
pause
goto edit_registry

:open_key
set /p "key_path=Enter the registry key path (e.g., HKLM\Software\Microsoft): "
echo Opening registry key: %key_path%
regedit /e temp.reg "%key_path%"
start notepad temp.reg
del temp.reg
pause
goto edit_registry

:open_hive
echo Choose a hive to open:
echo [1] HKEY_CLASSES_ROOT
echo [2] HKEY_CURRENT_USER
echo [3] HKEY_LOCAL_MACHINE
echo [4] HKEY_USERS
echo [5] HKEY_CURRENT_CONFIG
set /p "hive_choice=Enter your choice: "

if "%hive_choice%"=="1" set hive=HKEY_CLASSES_ROOT
if "%hive_choice%"=="2" set hive=HKEY_CURRENT_USER
if "%hive_choice%"=="3" set hive=HKEY_LOCAL_MACHINE
if "%hive_choice%"=="4" set hive=HKEY_USERS
if "%hive_choice%"=="5" set hive=HKEY_CURRENT_CONFIG
if not defined hive echo Invalid choice! Please try again. & pause & goto open_hive

echo Opening hive: %hive%
regedit /e temp.reg "%hive%"
start notepad temp.reg
del temp.reg
pause
goto edit_registry

:open_regedit
echo Launching Registry Editor...
start regedit
pause
goto edit_registry

:main_menu
goto :eof

:: Exit the tool
:exit
echo Exiting...
pause
:: Display read-only mode status
if "%READ_ONLY%"=="1" (
    echo Read-Only Mode: ENABLED
) else (
    echo Read-Only Mode: DISABLED
)
goto :eof
