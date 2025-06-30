#!/bin/bash
# TBESQ Gist Uploader
if [ -z "$1" ]; then
    echo "Usage: gist_upload.sh filename"
    exit 1
fi
if ! command -v gh >/dev/null 2>&1; then
  echo "GitHub CLI (gh) not found. Please install it first."
  exit 1
fi
gh gist create "$1" --public
