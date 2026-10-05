#When you want to restore a deleted document, follow these commands

#1-Make sure you are in the Paperless directory
cd ~/paperless

#2-Clear the export files from old files so backup can be extracted cleanly.
rm -rf export/*

#3-List the available backup files
ls backups
#e.g.,backup_2026-10-04.zip

#4-Extract the backup
unzip backups/backup_2026-10-04.zip -d export/

#5-Import the backup into Paperless
docker compose exec -T webserver document_importer ../export
#You will see your deleted document again !


#Do it for once




