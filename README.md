# TBESQ DOTFILES

this repo has the backbone necessary to migrate the tb-esq dev environment to whatever terminal we are working on.

## Structure

```
dotfiles/
├── .zshrc                # Shell config (zsh, Oh My Zsh, plugins, aliases, functions)
├── settings.json         # VS Code user settings (UI, linting, theme, keybindings)
├── extensions.txt        # VS Code extension IDs (one per line)
├── bootstrap.sh          # (optional) Setup script for symlinking/copying configs
└── README.md             # This file
```

## Usage

### Clone
```sh
git clone https://github.com/thunderbird-esq/dotfiles.git ~/dotfiles
```

### VS Code Setup

1. Copy `settings.json` to the user config folder:
    ```sh
    cp ~/dotfiles/settings.json ~/Library/Application\ Support/Code/User/settings.json
    ```
2. Install all VS Code extensions:
    ```sh
    cat ~/dotfiles/extensions.txt | xargs -L 1 code --install-extension
    ```

### Shell Setup

1. Copy or symlink `.zshrc`:
    ```sh
    cp ~/dotfiles/.zshrc ~/.zshrc
    ```
    *(Or symlink for easy updates: `ln -sf ~/dotfiles/.zshrc ~/.zshrc`)*

2. Reload shell:
    ```sh
    source ~/.zshrc
    ```

### Optional: Automated Bootstrap
If you have a `bootstrap.sh`, run:
```sh
cd ~/dotfiles && ./bootstrap.sh
```
This can automate symlinking, copying, and any setup you want.

---

