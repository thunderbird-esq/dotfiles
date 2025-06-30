# TBESQ DOTFILES

## Purpose

this repo is the fundamental resource kit for our shared dev environment at TBESQ HQ-—it's the terminal, editor, shell, automation, project bootstrapping, and Python tooling, all in one.

clone and bootstrap this directory on any Mac (or Linux) to be instantly “at home” in our environment with minimal manual setup.

---

## Structure

```
dotfiles/
├── .zshrc              # Shell config (Oh My Zsh, plugins, aliases, functions)
├── settings.json       # VS Code user settings (UI, linting, theme, keybindings)
├── extensions.txt      # VS Code extension IDs (one per line)
├── bootstrap.sh        # Automated setup, symlinks, Python/VS Code install, project prompt
├── requirements.txt    # Global Python CLI/dev tools (black, isort, flake8, etc)
├── bin/                # Executable helper scripts for dev and automation
└── README.md           # This file
```

---

## Initial Setup

### 1. Clone the Repo

```sh
git clone https://github.com/thunderbird-esq/dotfiles.git ~/dotfiles
```

### 2. Run the Bootstrap Script

```sh
cd ~/dotfiles
./bootstrap.sh
```

- this sets up our shell, VS Code config, global Python tools, makes all scripts in `bin/` executable, and can instantly scaffold a new project if you wish.

---

### Manual VS Code Setup (if needed)

- **User settings:**  
  ```sh
  cp ~/dotfiles/settings.json ~/Library/Application\ Support/Code/User/settings.json
  ```
- **Extensions:**  
  ```sh
  cat ~/dotfiles/extensions.txt | xargs -L 1 code --install-extension
  ```

---

### Manual Shell Setup (if needed)

- **Symlink or copy `.zshrc`:**
  ```sh
  cp ~/dotfiles/.zshrc ~/.zshrc
  # Or, for easy updates:
  ln -sf ~/dotfiles/.zshrc ~/.zshrc
  ```
- **Reload shell:**
  ```sh
  source ~/.zshrc
  ```

---

## Automation Helpers & Aliases

the `bin/` directory contains scripts for everything from project scaffolding to repo cloning, system updates, backups, and more.

| Script Name           | Usage/Alias     | Description                                    |
|-----------------------|-----------------|------------------------------------------------|
| newproject.sh         | `newproj`       | Scaffold a new project with venv and git       |
| brewsetup.sh          | `brewsetup`     | Install Homebrew CLI and cask apps             |
| fontsetup.sh          | `fontsetup`     | Install preferred coding fonts                 |
| repo_clone.sh         | `gclone`        | Bulk clone/update all org repos                |
| update_all.sh         | `brewup`        | Update all tools (brew, pip, npm)              |
| sysinfo.sh            | `sysinfo`       | System info/health check                       |
| clean_projects.sh     | `projclean`     | Clean Python/macos cruft from ~/Projects       |
| serve.sh              | `serve`         | Start a local web server                       |
| lintall.sh            | `lintall`       | Run black/isort/flake8 on all Python files     |
| gitprune.sh           | `gitprune`      | Prune merged branches in git                   |
| backup_dotfiles.sh    | `backupdot`     | Backup dotfiles to external drive              |
| dev_reminder.sh       | `todos`         | Show your TODO file in terminal                |
| gist_upload.sh        | `gpushgist`     | Create a public GitHub Gist from a file        |
| ...and more           |                 | Add your own as needed                         |

**all scripts are available everywhere thanks to `export PATH="$HOME/dotfiles/bin:$PATH"` in your `.zshrc`.**

---

## How to Start a New Project (TBESQ Workflow)

1. **Scaffold with one command:**
    ```sh
    newproj PROJECTNAME
    ```
    - Creates `~/Projects/PROJECTNAME`
    - Sets up `.venv`, `.gitignore`, `README.md`, and initializes git
    - Opens VS Code in the new project

2. **Or, run manually:**
    ```sh
    mkdir -p ~/Projects/PROJECTNAME
    cd ~/Projects/PROJECTNAME
    python3 -m venv .venv
    source .venv/bin/activate
    cp ~/dotfiles/.gitignore .
    echo "# PROJECTNAME" > README.md
    git init
    code .
    ```

3. **Commit and push to GitHub:**
    ```sh
    git add .gitignore README.md
    git add .         # Add other starter files
    git commit -m "Initial commit: project scaffold"
    # Create empty repo on GitHub, then:
    git remote add origin git@github.com:USERNAME/PROJECTNAME.git
    git branch -M main
    git push -u origin main
    ```

## Quick Reference: Updating Dotfiles

```sh
cd ~/dotfiles
git pull    # Get latest configs/scripts from your repo
./bootstrap.sh
source ~/.zshrc
```

---

**for more info, see script headers and inline docs in each file.  

---

# TBESQ
