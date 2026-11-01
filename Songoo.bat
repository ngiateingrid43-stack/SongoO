@echo off
title Songoo
setlocal enabledelayedexpansion

set PORT=%1
if "%PORT%"=="" set PORT=9001

echo ================================================
echo  Songoo — WASM Runner
echo ================================================
echo.
echo  Server: http://localhost:!PORT!/Songoo.html
echo  CTRL+C to stop.
echo.

:: Se placer dans le répertoire du script
pushd "%~dp0" || (
    echo Erreur : impossible d'accéder au répertoire "%~dp0"
    pause
    exit /b 1
)

:: Vérifier que le fichier HTML existe
if not exist "Songoo.html" (
    echo Erreur : fichier Songoo.html introuvable dans "%~dp0"
    echo Assurez-vous que la compilation WebAssembly a réussi.
    pause
    exit /b 1
)

:: Lancer le navigateur après un délai (1 seconde)
start /B "" cmd /c "timeout /t 1 /nobreak >nul & start "" "http://localhost:!PORT!/Songoo.html""

:: Démarrer le serveur HTTP
python -m http.server !PORT!
if errorlevel 1 (
    py -m http.server !PORT!
    if errorlevel 1 (
        python3 -m http.server !PORT!
        if errorlevel 1 (
            echo Erreur : impossible de démarrer le serveur HTTP.
            pause
            exit /b 1
        )
    )
)
popd
endlocal
