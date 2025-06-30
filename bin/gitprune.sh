#!/bin/bash
# TBESQ Git Clean/Prune Helper
git fetch --prune
git branch --merged | grep -v '\*' | xargs -n 1 git branch -d
echo "Git branches and remotes pruned."
