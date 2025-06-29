#!/bin/bash

# ================================
# TBESQ DOTFILES BOOTSTRAP SCRIPT
# ================================

set -e

GREEN='\033[0;32m'
RED='\033[0;31m'
CYAN='\033[0;36m'
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
    log "${RED}-> Backing up existing $1 to $1.backup.$(date +%s)${NC}"
    mv "$DST" "$DST.backup.$(date +%s)"
  fi
  if [ -f "$SRC" ]; then
    ln -sf "$SRC" "$DST"
    log "${GREEN}-> Symlinked $1${NC}"
  fi
}

install_vscode_settings() {
  # OS detection for settings path
  if [[ "$OSTYPE" == "darwin"* ]]; then
    VSCODE_USER_SETTINGS="$HOME/Library/Application Support/Code/User/settings.json"
  elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    VSCODE_USER_SETTINGS="$HOME/.config/Code/User/settings.json"
  else
    log "${RED}Unknown OS, cannot set VS Code user settings path.${NC}"
    return 1
  fi

  if [ -f "$VSCODE_USER_SETTINGS" ]; then
    log "${RED}-> Backing up existing VS Code settings.json${NC}"
    mv "$VSCODE_USER_SETTINGS" "$VSCODE_USER_SETTINGS.backup.$(date +%s)"
  fi
  mkdir -p "$(dirname "$VSCODE_USER_SETTINGS")"
  cp "$HOME/dotfiles/settings.json" "$VSCODE_USER_SETTINGS"
  log "${GREEN}-> Copied settings.json${NC}"
}

install_vscode_extensions() {
  if command -v code >/dev/null 2>&1; then
    log "${GREEN}-> Installing VS Code extensions from extensions.txt${NC}"
    cat "$HOME/dotfiles/extensions.txt" | xargs -L 1 code --install-extension
  else
    log "${RED}!! VS Code CLI ('code') not found. Skipping extension install.${NC}"
    log "   Open VS Code, Cmd+Shift+P, and type 'Shell Command: Install code command in PATH'."
  fi
}

install_homebrew() {
  if ! command -v brew >/dev/null 2>&1; then
    read -p "Homebrew not found. Install it? [y/N] " yn
    if [[ "$yn" =~ [Yy] ]]; then
      /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
      log "${GREEN}-> Homebrew installed.${NC}"
    else
      log "${RED}-> Homebrew not installed. Some features may be unavailable.${NC}"
    fi
  fi
}

main() {
  header

  # Optionally auto-install Homebrew
  install_homebrew

  # Interactive section selection
  read -p "Symlink .zshrc, .aliases, .p10k.zsh, .gitconfig? [Y/n] " symlink_ans
  if [[ "$symlink_ans" =~ ^[Nn]$ ]]; then
    log "Skipping shell config symlinks."
  else
    DOTFILES=(.zshrc .aliases .p10k.zsh .gitconfig)
    for file in "${DOTFILES[@]}"; do
      [ -f "$HOME/dotfiles/$file" ] && backup_and_symlink "$file"
    done
  fi

  read -p "Copy VS Code settings.json? [Y/n] " vs_ans
  if [[ ! "$vs_ans" =~ ^[Nn]$ ]]; then
    install_vscode_settings
  else
    log "Skipping VS Code settings copy."
  fi

  read -p "Install VS Code extensions? [Y/n] " ext_ans
  if [[ ! "$ext_ans" =~ ^[Nn]$ ]]; then
    install_vscode_extensions
  else
    log "Skipping VS Code extension install."
  fi

  read -p "Symlink universal .gitignore to \$HOME? [Y/n] " ign_ans
  if [[ ! "$ign_ans" =~ ^[Nn]$ ]]; then
    if [ ! -f "$HOME/.gitignore" ]; then
      ln -sf "$HOME/dotfiles/.gitignore" "$HOME/.gitignore"
      log "${GREEN}-> Symlinked universal .gitignore${NC}"
    else
      log "${RED}-> .gitignore already exists in HOME. Skipping.${NC}"
    fi
  else
    log "Skipping .gitignore symlink."
  fi

  log "${GREEN}==> [TBESQ BOOTSTRAP] Complete. Reload your shell with: source ~/.zshrc${NC}"
  log "  Log available at $LOG"
}

main "$@"

