#!/bin/bash
# TBESQ bulk repo cloner/updater
ORG="thunderbird-esq"
DEST="$HOME/Projects"

mkdir -p "$DEST"
cd "$DEST"
if ! command -v gh >/dev/null 2>&1; then
  echo "GitHub CLI (gh) not found. Please install it first."
  exit 1
fi
gh repo list $ORG --limit 100 --json name,sshUrl -q '.[] | .sshUrl' | while read repo; do
  git clone "$repo" || (cd "$(basename "$repo" .git)" && git pull)
done
