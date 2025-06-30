#!/bin/bash
# TBESQ Project Clean - remove cache/junk files
find ~/Projects -name "__pycache__" -type d -exec rm -rf {} +
find ~/Projects -name "*.pyc" -delete
find ~/ -name ".DS_Store" -delete
echo "Project caches and .DS_Store files removed."
