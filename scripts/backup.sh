nano backup.sh

# content

#!/usr/bin/env bash

# Exit immediately if any command fails
set -e

# Change to the directory where this script is located
cd "$(dirname "$0")"

# Create the backups directory if it does not already exist
mkdir -p backups

# Export Paperless-ngx documents from the webserver container
# -T disables pseudo-TTY allocation
# -z creates a compressed ZIP file
# --no-progress-bar hides the progress bar
docker compose exec -T webserver document_exporter ../export -z --no-progress-bar

# Move the exported ZIP file into the backups directory
# and rename it using the current date
mv export/export-*.zip backups/backup_$(date +%F).zip

# Delete backup files that are older than 7 days
find backups -name "*.zip" -mtime +7 -delete

# Display a message showing that the backup is complete
echo "Backup done: $(date)"

# Make the backup script executable
chmod +x backup.sh

# Run the backup script
./backup.sh

# List the backup files
ls backups