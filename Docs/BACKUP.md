# Backup and Restore

## 1. Overview

This document explains how to back up and restore documents in the Paperless-ngx .

| Item | Value |
|---|---|
| Tool | `document_exporter` / `document_importer`  (Official Paperless-ngx tools) |
| What is saved | Original documents + their data (tags, document types, correspondents, users, settings) |
| Backup format | One zip file per day: `backup_YYYY-MM-DD.zip` |
| Storage location | `~/paperless/backups/` on the VM |
| Schedule | 5 minutes after every VM boot, and daily at 12:30 UTC (15:30 Saudi time) if the VM is running |
| Retention | 7 days (older backups are deleted automatically) |
---

## 2. Backup 
### 2.1 Create the script

```bash
cd ~/paperless
nano backup.sh
```

Paste the following content ( file: `backup.sh`):

```bash
#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"
mkdir -p backups export

# Start from a clean export folder
rm -rf export/*

# Export all documents + metadata into a single zip file
docker compose exec -T webserver document_exporter ../export -z --no-progress-bar

# Move the file to the backups folder with the date in its name
FILE="backups/backup_$(date +%F).zip"
mv export/export-*.zip "$FILE"

# Verify the zip is not corrupted
unzip -tq "$FILE"

# Delete backups older than 7 days
find backups -name "*.zip" -mtime +7 -delete
echo "Backup done: $(date)"
```

### 2.2 Make it executable

```bash
chmod +x backup.sh
```

### 2.3 Run a manual test

```bash
./backup.sh
ls -lh backups
```

Expected: `No errors detected in compressed data` and `Backup done`.


---
### 2.2 Schedule it with cron
The VM is not running 24/7 (it is stopped to save cost), so a fixed night-time job would
never run. The backup is scheduled at boot and at a daily time during working hours.
 
```bash
crontab -e
```


Add these two lines:
 
```
@reboot sleep 300 && flock -n /tmp/paperless-backup.lock /home/azureuser/paperless/backup.sh >> /home/azureuser/paperless/backup.log 2>&1
30 12 * * * flock -n /tmp/paperless-backup.lock /home/azureuser/paperless/backup.sh >> /home/azureuser/paperless/backup.log 2>&1
```
 
- `@reboot` + `sleep 300`: waits 5 minutes so the containers are up.
- `30 12 * * *`: daily at 12:30 UTC (15:30 Saudi time, UTC+3).
- `flock`: prevents two backups from running at the same time.
- Output and errors are written to `backup.log`.

Check:
 
```bash
crontab -l | tail -3
tail -5 ~/paperless/backup.log
```

### 2.3 Stopping the VM
 
Take a backup right before stopping the VM, then deallocate it (a normal shutdown still
bills compute; only **Stopped (deallocated)** stops compute billing).

---

## 3. Restore 

### 3.1 Create the script

```bash
cd ~/paperless
nano restore.sh
```
```bash
#!/usr/bin/env bash

#1-Check Errors
set -euo pipefail

#2-Moving to the folder ,where the script lives
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
```
```bash
chmod +x restore.sh
```

Running `./restore.sh` without an argument only prints usage and the list of backups.

### 3.2 Restore documents

1. Check the Trash first (Paperless-ngx interface). Documents deleted recently can be restored there.

2. If the documents were deleted permanently, choose a backup made **before** the deletion:

```bash
cd paperless
ls -lh backups
cp backups/backup_<date>.zip ~/safe_backup_<date>.zip   # keep a safe copy
./restore.sh backup_<date>.zip
 ```

 3. Type `yes` and wait for `Restore done`.


 > Do not run `backup.sh` before the restore is finished: a new backup made after the
> deletion has the same file name for the same day and overwrites the good backup.
 

### 3.3 Verify
 
1. Open Paperless-ngx interface (`http://<VM-IP>:8000`) and refresh the page.
2. Search for a restored document.
3. Open it and check the file, tags and metadata. 


## 4. Troubleshooting
| Problem | What to check |
|---|---|
| No backup after a boot | `tail ~/paperless/backup.log`, `systemctl is-active cron`, `docker compose ps` |
| `mv: cannot stat export/export-*.zip` | The export failed; check `docker compose logs webserver` |
| Backup file much smaller than before | Documents were deleted before the backup; restore from an older zip |
| `Permission denied` on `export/` | Run the commands with `sudo`, or check the owner of `export/` |
| Import fails with a version error | Use the same Paperless-ngx version as the backup |
| `unzip` test fails | The backup is corrupted; use an older backup |

## 5. Test Result

The restore was tested end to end: a document was deleted from the web interface, then restored from the backup, and it returned with its original data.

---

