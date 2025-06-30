# TBESQ DOTFILES

this repo has the backbone necessary to migrate the tb-esq dev environment to whatever terminal we are working on.

## Structure

dotfiles/
├── .zshrc                # Shell config (zsh, Oh My Zsh, plugins, aliases, functions)
├── settings.json         # VS Code user settings (UI, linting, theme, keybindings)
├── extensions.txt        # VS Code extension IDs (one per line)
├── bootstrap.sh          # (optional) Setup script for symlinking/copying configs
└── README.md             # This file


## INITIAL SETUP ##

### Clone

git clone https://github.com/thunderbird-esq/dotfiles.git ~/dotfiles


### VS Code Setup

1. Copy `settings.json` to the user config folder:

    cp ~/dotfiles/settings.json ~/Library/Application\ Support/Code/User/settings.json
    
2. Install all VS Code extensions:
    
    cat ~/dotfiles/extensions.txt | xargs -L 1 code --install-extension
    

### Shell Setup

1. Copy or symlink `.zshrc`:

    cp ~/dotfiles/.zshrc ~/.zshrc
    *(Or symlink for easy updates: `ln -sf ~/dotfiles/.zshrc ~/.zshrc`)*

2. Reload shell:

    source ~/.zshrc
    

### Optional: Automated Bootstrap
If you have a `bootstrap.sh`, run:

cd ~/dotfiles && ./bootstrap.sh

this can automate symlinking, copying, and any setup you want.

---

---

## How to Start a New Project (TBESQ Workflow)

whenever you want to begin a new codebase, script, or project, follow this streamlined process:

### 1. Scaffold Your Project

you can use your `newproj` function defined in the `.zshrc`:

newproj PROJECTNAME

what this does:

creates ~/Projects/PROJECTNAME

creates and activates a Python virtual environment .venv

initializes an empty README.md, .gitignore, and local git repo

opens the project in VS Code


now, if you want to do it manually:

mkdir -p ~/Projects/PROJECTNAME
cd ~/Projects/PROJECTNAME
python3 -m venv .venv
source .venv/bin/activate
cp ~/dotfiles/.gitignore .
echo "# PROJECTNAME" > README.md
git init
code .

### 2. (Optional) Add Project-Specific Files

create any other starter files you need (requirements.txt, source folders, etc.)

add all your code, data, and assets

3. make yr first commit

git add .gitignore README.md
git add .         # Add any other starter files
git commit -m "Initial commit: project scaffold"

4. create a Remote repo on gh

go to GitHub and create a new repository w yr project's name

don't add any files on GitHub (local repo already has them)

5. Link and Push to GitHub

git remote add origin git@github.com:USERNAME/PROJECTNAME.git
git branch -M main
git push -u origin main

### TIP:
keep yr dotfiles/.gitignore, settings.json, and extensions.txt updated for instant reproducibility on any future project or hardware.


