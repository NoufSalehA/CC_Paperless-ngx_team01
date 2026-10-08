# Maintenance
 
 
Connect to the VM first:
 
```bash
az login
ssh azureuser@<VM_PUBLIC_IP>
cd ~/paperless
```
 
## 1. Update Paperless-ngx
 
Our `docker-compose.yml` uses the `latest` image, which is always the latest stable release.
 
1. Read the release notes of the new version:
   `https://github.com/paperless-ngx/paperless-ngx/releases`
2. Open the web UI, go to **Tasks**, and make sure no document is being processed.
3. Take a backup:
```bash
   bash backup.sh
```
4. Stop Paperless:
```bash
   docker compose down
```
5. Pull the new images and start again:
```bash
   bash deploy.sh
```
   `deploy.sh` runs `docker compose config`, `docker compose pull`, and `docker compose up -d`. Starting the containers also applies any new database migrations automatically.
6. Check the services:
```bash
   bash health_check.sh
```
 