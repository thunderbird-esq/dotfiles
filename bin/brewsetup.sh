
# TBESQ Homebrew Installer

BREW_APPS=(git python3 wget htop tmux)
BREW_CASKS=(iterm2 visual-studio-code)

echo "==> Installing Homebrew packages..."
for app in "${BREW_APPS[@]}"; do
  brew install "$app"
done

echo "==> Installing Homebrew casks..."
for cask in "${BREW_CASKS[@]}"; do
  brew install --cask "$cask"
done

echo "==> Done. All essentials installed."
