#!/bin/bash
# TBESQ Universal Updater
brew update && brew upgrade
pip3 list --outdated
npm -g outdated
echo "Update complete!"
