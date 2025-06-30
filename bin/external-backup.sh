#!/bin/bash
DEST="/Volumes/USBKEY/dotfiles_backup_$(date +%Y%m%d).zip"
cd ~
zip -r "$DEST" dotfiles
echo "Dotfiles backup created at $DEST"

