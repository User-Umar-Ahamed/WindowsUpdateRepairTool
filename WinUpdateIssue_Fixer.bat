@echo off
title Windows Update Repair Tool - Developed by Umar Ahamed
color 0A
cls

:: Check for admin rights
>nul 2>&1 net session || (
    echo ===========================================================
    echo  This tool must be run as Administrator!
    echo  Please right-click on this file and select 'Run as Admin'.
    echo ===========================================================
    pause
    exit /b
)

:MENU
cls
echo =============================================================
echo       Windows Update Repair Tool - By Umar Ahamed
echo =============================================================
echo.
echo Choose an option below:
echo.
echo  1. Full Windows Update Reset
echo  2. Check System Health (SFC and DISM)
echo  3. Delete Update Cache Only
echo  4. Restart Windows Update Services
echo  5. Fix Stuck or Failed Updates
echo  6. Update All Applications (via Winget)
echo  0. Exit
echo.
set /p option="Enter your choice (0-6): "

IF "%option%"=="1" GOTO FULL_RESET
IF "%option%"=="2" GOTO HEALTH_CHECK
IF "%option%"=="3" GOTO DELETE_CACHE
IF "%option%"=="4" GOTO RESTART_SERVICES
IF "%option%"=="5" GOTO FIX_STUCK
IF "%option%"=="6" GOTO UPDATE_APPS
IF "%option%"=="0" EXIT
GOTO MENU

:PROGRESS_BAR
setlocal enabledelayedexpansion
set /a progress=0

:LOOP
set /a progress+=10
if !progress! leq 100 (
    cls
    echo Processing: !progress!%%
    ping localhost -n 1 >nul
    goto LOOP
)
endlocal
exit /b

:FULL_RESET
cls
echo Performing Full Windows Update Reset...
call :PROGRESS_BAR
call :STOP_SERVICES
echo Deleting temporary update files...
rd /s /q %systemroot%\SoftwareDistribution >nul 2>&1
rd /s /q %systemroot%\System32\catroot2 >nul 2>&1
echo Resetting system DLLs...
regsvr32 /s wuapi.dll
regsvr32 /s wuaueng.dll
regsvr32 /s wuaueng1.dll
regsvr32 /s wucltui.dll
regsvr32 /s wups.dll
regsvr32 /s wups2.dll
regsvr32 /s wuweb.dll
regsvr32 /s msxml.dll
regsvr32 /s msxml3.dll
regsvr32 /s msxml6.dll
call :RESTART_SERVICES
echo.
echo ============================================
echo Full reset completed. Restart your PC.
echo ============================================
pause
GOTO MENU

:HEALTH_CHECK
cls
echo Running System File Checker (SFC)...
call :PROGRESS_BAR
sfc /scannow

echo.
echo Running DISM RestoreHealth...
call :PROGRESS_BAR
DISM /Online /Cleanup-Image /RestoreHealth

echo.
echo ============================================
echo Health check completed. Restart if needed.
echo ============================================
pause
GOTO MENU

:DELETE_CACHE
cls
echo This will delete Windows Update cache folders.
echo.
echo ============================================
echo WARNING: This operation cannot be undone.
echo ============================================
echo.
echo Press Enter to continue or close this window to cancel...
pause >nul
cls
echo Stopping services...
call :STOP_SERVICES
echo Deleting update cache...
call :PROGRESS_BAR
rd /s /q %systemroot%\SoftwareDistribution >nul 2>&1
rd /s /q %systemroot%\System32\catroot2 >nul 2>&1
call :RESTART_SERVICES
echo.
echo ============================================
echo Update cache cleared successfully.
echo ============================================
pause
GOTO MENU

:RESTART_SERVICES
cls
echo Restarting Windows Update services...
call :PROGRESS_BAR
net start wuauserv >nul 2>&1
net start cryptSvc >nul 2>&1
net start bits >nul 2>&1
net start msiserver >nul 2>&1
echo.
echo ============================================
echo Services restarted successfully.
echo ============================================
pause
GOTO MENU

:FIX_STUCK
cls
echo Fixing stuck or failed Windows Updates...
call :STOP_SERVICES
echo Removing pending updates...
del /f /q %windir%\winsxs\pending.xml >nul 2>&1
echo Renaming SoftwareDistribution folder...
ren %windir%\SoftwareDistribution SoftwareDistribution.bak >nul 2>&1
echo Renaming Catroot2 folder...
ren %windir%\System32\catroot2 catroot2.bak >nul 2>&1
echo Resetting BITS queue...
bitsadmin /reset /allusers >nul 2>&1
echo.
call :RESTART_SERVICES
echo ============================================
echo Stuck updates fixed. Restart and check again.
echo ============================================
pause
GOTO MENU

:UPDATE_APPS
cls
echo Updating all installed applications via Winget...
echo NOTE: This may take several minutes...
call :PROGRESS_BAR
winget upgrade --all
echo.
echo ============================================
echo All apps updated successfully (via Winget).
echo ============================================
pause
GOTO MENU

:STOP_SERVICES
echo Stopping Windows Update services...
net stop wuauserv >nul 2>&1
net stop cryptSvc >nul 2>&1
net stop bits >nul 2>&1
net stop msiserver >nul 2>&1
GOTO :EOF
