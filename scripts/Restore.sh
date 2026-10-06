#!/usr/bin/env bash

#1-Check Errors
set -euo pipefail

#2-Go to the folder ,where the script lives
cd "$(dirname "$0")"

#3.1-Reading Backup file name
BACKUP="${1:-}"

#3.2-If the file has any issue, list available backups and stop.
if [ -z "$BACKUP" ] || [ ! -f "backups/$BACKUP" ]; then
  echo "Usage: ./restore.sh <backup_file.zip>"
  echo "Available backups:"; ls backups/
  exit 1
fi

#4-Make sure The webserver container is running
if ! docker compose ps --status running --services | grep -qx webserver; then
  echo "ERROR: webserver is not running. Run: docker compose up -d"
  exit 1
fi

#5-Confirm before overwriting data
read -r -p "Restore from $BACKUP? Existing data may be overwritten. (yes/no) " ANSWER
[ "$ANSWER" = "yes" ] || { echo "Cancelled."; exit 0; }

#6-Checks the ZIP backup for errors
unzip -tq "backups/$BACKUP"

#7-Empty export folder
rm -rf export/*

#8-Extract the backup files into export folder
unzip -q "backups/$BACKUP" -d export/

#9-Imports documents from export into Paperless
docker compose exec -T webserver document_importer ../export --no-progress-bar

#10-Print restore is done
echo "Restore done: $(date)"



