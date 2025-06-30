#!/bin/bash

set -e

# --- COLORS ---
GREEN='\033[0;32m'
RED='\033[0;31m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
NC='\033[0m'

LOG="$HOME/dotfiles/bootstrap.log"
touch "$LOG"

header() {
  echo -e "${CYAN}===================================================="
  echo    "TBESQ DOTFILES BOOTSTRAP $(date)"
  echo    "Running as $(whoami) on $(hostname) [$OSTYPE]"
  echo -e "====================================================${NC}"
}

log() {
  echo -e "$1" | tee -a "$LOG"
}

backup_and_symlink() {
  local SRC="$HOME/dotfiles/$1"
  local DST="$HOME/$1"
  if [ -f "$DST" ] || [ -L "$DST" ]; then
    log "${YELLOW}-> Backing up existing $1 to $1.backup.$(date +%s)${NC}"
    mv "$DST" "$DST.backup.$(date +%s)"
  fi
  if [ -f "$SRC" ]; then
    ln -sf "$SRC" "$DST"
    log "${GREEN}-> Symlinked $1${NC}"
  fi
}

install_vscode_settings() {
  if [[ "$OSTYPE" == "darwin"* ]]; then
    VSCODE_USER_SETTINGS="$HOME/Library/Application Support/Code/User/settings.json"
  elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    VSCODE_USER_SETTINGS="$HOME/.config/Code/User/settings.json"
  else
    log "${RED}Unknown OS, cannot set VS Code user settings path.${NC}"
    return 1
  fi

  if [ -f "$VSCODE_USER_SETTINGS" ]; then
    log "${YELLOW}-> Backing up existing VS Code settings.json${NC}"
    mv "$VSCODE_USER_SETTINGS" "$VSCODE_USER_SETTINGS.backup.$(date +%s)"
  fi
  mkdir -p "$(dirname "$VSCODE_USER_SETTINGS")"
  cp "$HOME/dotfiles/settings.json" "$VSCODE_USER_SETTINGS"
  log "${GREEN}-> Copied settings.json${NC}"
}

install_vscode_extensions() {
  if command -v code >/dev/null 2>&1; then
    log "${GREEN}-> Installing VS Code extensions from extensions.txt${NC}"
    cat "$HOME/dotfiles/extensions.txt" | xargs -L 1 code --install-extension || \
    log "${YELLOW}!! Some extensions failed to install (possible OS/CLI limitation). Please install extensions manually if needed.${NC}"
  else
    log "${YELLOW}!! VS Code CLI ('code') not found. Skipping extension install.${NC}"
    log "   Open VS Code, Cmd+Shift+P, and type 'Shell Command: Install code command in PATH'."
  fi
}

install_python_requirements() {
  if command -v python3 >/dev/null 2>&1 && command -v pip3 >/dev/null 2>&1 && [ -f "$HOME/dotfiles/requirements.txt" ]; then
    log "${GREEN}-> Installing Python developer CLI tools from requirements.txt${NC}"
    pip3 install --user -r "$HOME/dotfiles/requirements.txt" || \
    log "${YELLOW}!! Some Python requirements failed to install. Please check manually.${NC}"
  else
    log "${YELLOW}!! Python3 and/or pip3 not found, or requirements.txt missing. Skipping Python dev tools install.${NC}"
  fi
}

make_bin_executable() {
  if [ -d "$HOME/dotfiles/bin" ]; then
    chmod +x "$HOME/dotfiles/bin/"*.sh
    log "${GREEN}-> Ensured all bin/ scripts are executable${NC}"
  fi
}

main() {
  header

  # Symlink configs
  DOTFILES=(.zshrc .aliases .p10k.zsh .gitconfig)
  for file in "${DOTFILES[@]}"; do
    [ -f "$HOME/dotfiles/$file" ] && backup_and_symlink "$file"
  done

  # VS Code settings and extensions
  install_vscode_settings
  install_vscode_extensions

  # Python developer CLI tools
  install_python_requirements

  # Ensure bin scripts are executable
  make_bin_executable

  # Prompt for new project creation
  read -p "Scaffold a new TBESQ project now? [y/N] " ans
  if [[ "$ans" =~ ^[Yy]$ ]]; then
    read -p "Enter project name: " pname
    if [ ! -z "$pname" ]; then
      "$HOME/dotfiles/bin/newproject.sh" "$pname"
    fi
  fi

  log "${GREEN}==> [TBESQ BOOTSTRAP] Complete. Reload your shell with: source ~/.zshrc${NC}"
  log "  Log available at $LOG"
}

main "$@"

