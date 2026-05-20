#!/usr/bin/env bash
set -euo pipefail

REPO_URL="https://github.com/MrKraken/StarStrings.git"
BASE_DIR="$HOME/Games/star-citizen/drive_c/Program Files/Roberts Space Industries/StarCitizen/LIVE"
BRANCH="master"

TARGET_FILE="Data/Localization/english/global.ini"
LANG_LINE='g_language = english'

echo "== StarStrings updater =="

cd "$BASE_DIR"

if [ ! -d ".git" ]; then
    echo "Initializing repository..."

    git init
    git remote add origin "$REPO_URL"
fi

echo "Fetching latest files..."
git fetch origin "$BRANCH"

echo "Downloading $TARGET_FILE ..."
git checkout "origin/$BRANCH" -- "$TARGET_FILE"

echo "Searching for existing USER.cfg ..."

USER_CFG=$(find . -maxdepth 1 -iname "user.cfg" | head -n 1)

if [ -z "$USER_CFG" ]; then
    echo "No USER.cfg found, creating one..."
    USER_CFG="./USER.cfg"
    touch "$USER_CFG"
fi

echo "Using config file: $USER_CFG"

if grep -Fxiq "$LANG_LINE" "$USER_CFG"; then
    echo "Language setting already present."
else
    echo "Adding language setting to $USER_CFG ..."
    echo "$LANG_LINE" >> "$USER_CFG"
fi

echo "Done."
