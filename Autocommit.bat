@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion

REM Demander un message de commit
set /p commit_msg=Entrez le message du commit :

REM Nettoyer le message pour créer un tag valide (remplacer espaces par tirets, supprimer caractères spéciaux)
set tag_name=%commit_msg%
set tag_name=%tag_name: =-%
set tag_name=%tag_name:.=%
set tag_name=%tag_name:,=%
set tag_name=%tag_name:"=%
set tag_name=%tag_name:'=%
set tag_name=%tag_name:;=%
set tag_name=%tag_name:!=%
set tag_name=%tag_name:~=%
set tag_name=%tag_name:^=%

REM Ajouter le préfixe V
set tag_name=V%tag_name%

REM Exécuter les commandes Git
echo 🌀 Création du commit : %commit_msg%
echo 🏷️ Tag créé : %tag_name%

git status
git add .
git commit -m "%commit_msg%"
git tag %tag_name%
git push origin main
git push origin %tag_name%

echo ✅ Version %tag_name% poussée avec succès !
pause