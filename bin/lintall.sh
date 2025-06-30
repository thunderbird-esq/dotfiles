#!/bin/bash
# TBESQ Python Lint/Format All
black .
isort .
flake8 .
echo "Formatting and linting complete."
