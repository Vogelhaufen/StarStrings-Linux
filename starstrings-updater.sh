#!/usr/bin/env bash
set -euo pipefail

REPO_URL="https://github.com/MrKraken/StarStrings.git"
BASE_DIR="$HOME/Games/star-citizen/drive_c/Program Files/Roberts Space Industries/StarCitizen/LIVE"
BRANCH="master"

echo "== StarStrings updater =="

cd "$BASE_DIR"

if [ ! -d ".git" ]; then
    echo "Initializing repository..."

    git init
    git remote add origin "$REPO_URL"

    git fetch origin
    git checkout -b "$BRANCH" "origin/$BRANCH"
else
    echo "Updating repository..."

    git fetch origin

    # update everything except USER.cfg
    git checkout "origin/$BRANCH" -- . ':!USER.cfg'
fi

echo "Done."
