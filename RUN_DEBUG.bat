@echo off
setlocal
cd /d "%~dp0"
title Vialumix - Diagnostic

echo ============================================================
echo VIALUMIX DIAGNOSTIC
echo ============================================================
echo Dossier : %CD%
echo.
echo Java du PATH :
where java 2>nul
if errorlevel 1 echo [INFO] java.exe absent du PATH
echo.
echo Version Java :
java -version 2>&1
echo.
if exist "%APPDATA%\.minecraft" (echo [OK] .minecraft : %APPDATA%\.minecraft) else echo [INFO] .minecraft introuvable
if exist "tools\BUILD_AND_INSTALL.bat" (echo [OK] script build present) else echo [ERREUR] script build absent
echo.
pause
endlocal
