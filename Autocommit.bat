@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion

REM Récupérer le dernier tag Git commençant par v suivi d’un chiffre (ex: v0.14)
for /f "delims=" %%i in ('git tag --sort=-v:refname ^| findstr /r "^v[0-9]"') do (
    if not defined last_tag (
        set last_tag=%%i
    )
)

REM Si aucun tag trouvé, on commence à 0.5
if "%last_tag%"=="" (
    set new_version=0.5
) else (
    REM Supprimer le "v" du tag
    set "current_version=%last_tag:~1%"
    REM Extraire la partie entière et décimale
    for /f "tokens=1,2 delims=." %%a in ("%current_version%") do (
        set /a major=%%a
        set /a minor=%%b + 1
        if !minor! lss 10 (
            set new_version=!major!.0!minor!
        ) else (
            set /a major+=1
            set minor=00
            set new_version=!major!.!minor!
        )
    )
)

REM Demander un message de commit
set /p commit_msg=Entrez le message du commit :

REM Afficher la version proposée
echo Nouvelle version : v%new_version%

REM Exécuter les commandes Git
git status
git add .
git commit -m "v%new_version% %commit_msg%"
git tag v%new_version%
git push origin main
git push origin v%new_version%

echo ✅ Version v%new_version% poussée avec succès !
pause