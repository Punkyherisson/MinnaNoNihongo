@echo off
chcp 65001 >nul
setlocal

REM Demander le message de commit (qui servira aussi de tag)
set /p commit_msg=Entrez le message du commit :

REM Créer le tag basé sur le message de commit
set tag_name=%commit_msg%

REM Afficher les informations
echo 🌀 Création du commit : %commit_msg%
echo 🏷️ Tag créé : %tag_name%

REM Exécuter les commandes Git
git status
git add .
git commit -m "%commit_msg%"
git tag "%tag_name%"
git push origin main
git push origin "%tag_name%"

echo ✅ Commit et tag "%tag_name%" poussés avec succès !
pause