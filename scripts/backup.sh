#!/usr/bin/env bash

# Check Errors
set -euo pipefail

# Go to the folder ,where the script lives
cd "$(dirname "$0")"

# Create the backups and export folders if missing
mkdir -p backups export

# Start from a clean export folder
rm -rf export/*

# Export all documents + metadata into a single zip file
docker compose exec -T webserver document_exporter ../export -z --no-progress-bar

# Move the file to backups/ with the date in its name
FILE="backups/backup_$(date +%F).zip"
mv export/export-*.zip "$FILE"

# Verify the zip is not corrupted
unzip -tq "$FILE"

# Delete backups older than 7 days
find backups -name "*.zip" -mtime +7 -delete
echo "Backup done: $(date)"




