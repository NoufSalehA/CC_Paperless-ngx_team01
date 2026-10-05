# Backup and Restore

## 1. Overview

This document describes how to back up and restore the Paperless-ngx platform.

| Item | Value |
|---|---|
| Tool | `document_exporter` (the official Paperless-ngx tool) |
| What is saved | Original documents + their data (tags, document types, correspondents, users, settings) |
| Backup format | One zip file per day: `backup_YYYY-MM-DD.zip` |
| Storage location | `~/paperless/backups/` on the VM |
| Schedule | Daily at 02:00 UTC (05:00 Saudi time) via cron |
| Retention | 7 days (older backups are deleted automatically) |

---

## 2. Backup Setup (one time only)

### 2.1 Create the script

```bash
cd ~/paperless
nano backup.sh
```

Paste the following content (file: `scripts/backup.sh`):

```bash
#!/usr/bin/env bash
set -e
cd "$(dirname "$0")"
mkdir -p backups

# Export all documents + metadata into a single zip file
docker compose exec -T webserver document_exporter ../export -z --no-progress-bar

# Move the file to the backups folder with the date in its name
mv export/export-*.zip backups/backup_$(date +%F).zip

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
ls backups
```

A file named `backup_YYYY-MM-DD.zip` should appear.

---

## 3. Verification and Scheduling

### 3.1 Install prerequisites

```bash
sudo apt install -y unzip
```

### 3.2 Verify the backup

```bash
unzip -l backups/backup_$(date +%F).zip | head
```

You should see `manifest.json` and the documents folder.

### 3.3 Schedule the daily backup

```bash
crontab -e
```

Add this line at the end of the file:

```
0 2 * * * /home/azureuser/paperless/backup.sh >> /home/azureuser/paperless/backup.log 2>&1
```

> The VM runs on UTC time, so 02:00 means 05:00 Saudi time.

---

## 4. Restore Procedure

Run this when data is lost, or to test the backups.

```bash
cd ~/paperless

# 1) Clean the export folder
rm -rf export/*

# 2) Unzip the desired backup (change the date)
unzip backups/backup_2026-10-04.zip -d export/

# 3) Import into Paperless
docker compose exec -T webserver document_importer ../export
```

Then open the Paperless web interface and confirm that the documents and tags are back.

### If the import is refused because the system is not empty

`document_importer` is designed to restore onto a fresh, empty system. If you get an error to that effect:

```bash
docker compose down -v      # deletes current Paperless data (backups in backups/ stay safe)
docker compose up -d
sleep 60                    # wait for the service to be ready
docker compose exec -T webserver document_importer ../export
```

---

## 5. Monitoring and Maintenance

| Check | Command |
|---|---|
| List existing backups | `ls -lh ~/paperless/backups` |
| Scheduled run log | `cat ~/paperless/backup.log` |
| Cron service status | `systemctl status cron` |

A new backup should appear every day, and the log should contain `Backup done`.

---

## 6. Test Result

The restore was tested end to end: a document was deleted from the web interface, then restored from the backup, and it returned with its original data.

---

