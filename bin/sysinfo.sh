#!/bin/bash
# TBESQ System Info/Health Check
echo "=== SYSTEM INFO ==="
uname -a
echo
echo "=== Disk Usage ==="
df -h
echo
echo "=== Memory ==="
vm_stat
echo
echo "=== Homebrew Outdated ==="
brew outdated
