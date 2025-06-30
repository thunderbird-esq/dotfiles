#!/bin/bash
# TBESQ Dev Reminder/TODO Ticker
TODO_FILE="$HOME/Projects/TODO.md"
if [ -f "$TODO_FILE" ]; then
    cat "$TODO_FILE"
else
    echo "No TODO file found at $TODO_FILE."
fi
