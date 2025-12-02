#!/bin/bash

echo "https://github.com/andikabegeng/LegacySimulationApi.git"
read REPO_URL

git init
git add .
git commit -m "Initial commit"
git branch -M main
git remote add origin $REPO_URL
git push -u origin main
