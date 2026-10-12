@echo off
rem Runs every test of the qgame package. Needs qaxlc on PATH (the QAX-LANG setup installs it).
setlocal enabledelayedexpansion
cd /d "%~dp0"
set FAIL=0
qaxlc selftest.qax -o selftest.exe >nul || exit /b 1
selftest.exe || set FAIL=1
qaxlc negative.qax -o negative.exe >nul || exit /b 1
set I=0
call :neg !I! grid
set /a I+=1
call :neg !I! grid
set /a I+=1
call :neg !I! grid
set /a I+=1
call :neg !I! grid
set /a I+=1
call :neg !I! grid
set /a I+=1
call :neg !I! grid
set /a I+=1
call :neg !I! grid
set /a I+=1
call :neg !I! grid
set /a I+=1
call :neg !I! rect
set /a I+=1
call :neg !I! rect
set /a I+=1
call :neg !I! rng
set /a I+=1
call :neg !I! rng
set /a I+=1
call :neg !I! rng
set /a I+=1
call :neg !I! rng
set /a I+=1
call :neg !I! clock
set /a I+=1
call :neg !I! clock
set /a I+=1
call :neg !I! rng
set /a I+=1
echo qgame negative cases: !I! run
del selftest.exe negative.exe neg.txt 2>nul
exit /b %FAIL%
:neg
echo %1| negative.exe 2>neg.txt >nul
set CODE=!errorlevel!
findstr /c:"assertion failed [%2.qax:" neg.txt >nul
if !errorlevel! neq 0 (echo FAIL: negative case %1 & set FAIL=1) else if !CODE! neq 101 (echo FAIL: negative case %1 exit !CODE! & set FAIL=1)
exit /b 0
