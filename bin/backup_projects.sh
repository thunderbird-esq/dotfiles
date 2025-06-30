# TBESQ Projects Backup (edit BACKUP_DIR as needed)

BACKUP_DIR="/Volumes/BACKUP_DRIVE/ProjectsBackup"
SRC_DIR="$HOME/Projects"

if [ ! -d "$BACKUP_DIR" ]; then
  echo "Backup drive not mounted at $BACKUP_DIR. Exiting."
  exit 1
fi

rsync -avh --delete "$SRC_DIR/" "$BACKUP_DIR/"
echo "Backup complete: $SRC_DIR -> $BACKUP_DIR"
