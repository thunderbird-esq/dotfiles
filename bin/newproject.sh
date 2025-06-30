
# TBESQ Project Bootstrapper

set -e

if [ -z "$1" ]; then
  echo "Usage: newproject.sh PROJECTNAME"
  exit 1
fi

PROJ="$HOME/Projects/$1"
mkdir -p "$PROJ"
cd "$PROJ"
python3 -m venv .venv
source .venv/bin/activate
cp ~/dotfiles/.gitignore .
echo "# $1" > README.md
git init
code .

