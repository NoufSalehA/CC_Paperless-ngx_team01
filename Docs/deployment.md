# Deployment 
 
## Step 1: Get your public IP
 
Run on your own computer. You need it for `allowed_web_cidrs`.
 
```bash
curl -4 ifconfig.me
```
 
On Windows PowerShell use `curl.exe -4 ifconfig.me`.
 
## Step 2: Sign in to Azure
 
First, enter the Azure portal, create a user account, and choose the Pay-As-You-Go subscription.

Then:
```bash
az login
az account show --query id -o tsv      # your subscription_id
```
 
## Step 3: Create the infrastructure with Terraform
 
Edit `terraform.tfvars` and add your `subscription_id` and the IP addresses (with `/32`):
 
```hcl
subscription_id = "<your-subscription-id>"
allowed_ssh_ip  = "203.0.113.10/32"
allowed_web_cidrs = [
  "203.0.113.10/32",   # User 1
  "203.0.113.11/32",   # User 2
]
```
 
Then run:
 
```bash
cd <peoject_folder_name > 
cd terraform
terraform init
terraform validate
terraform plan
terraform apply
```
 
Terraform asks for `admin_password` (the VM password). Type `yes` to confirm.

 
## Step 4: Connect to the VM
 
```bash
ssh azureuser@<VM_PUBLIC_IP>
```
 
## Step 5: Install Docker
 
```bash
sudo apt-get update && sudo apt-get upgrade -y
curl -fsSL https://get.docker.com | sudo sh
sudo usermod -aG docker $USER
exit
```
 
Reconnect so the docker group applies, then check:
 
```bash
ssh azureuser@<VM_PUBLIC_IP>
docker --version
docker compose version
```
 
## Step 6: Download Paperless-ngx and Docker Compose files
 
```bash
mkdir -p ~/paperless && cd ~/paperless
wget https://raw.githubusercontent.com/paperless-ngx/paperless-ngx/main/docker/compose/docker-compose.postgres.yml -O docker-compose.yml
wget https://raw.githubusercontent.com/paperless-ngx/paperless-ngx/main/docker/compose/docker-compose.env
wget https://raw.githubusercontent.com/paperless-ngx/paperless-ngx/main/docker/compose/.env
```
 
## Step 7: Configure Paperless
 
```bash
id -u && id -g                          # must match USERMAP_UID and USERMAP_GID in docker-compose.env
python3 -c "import secrets; print(secrets.token_urlsafe(64))"
nano docker-compose.env
```
 
In `docker-compose.env` set:
 
```env
PAPERLESS_SECRET_KEY=<the generated key>
PAPERLESS_TIME_ZONE=Asia/Riyadh
PAPERLESS_OCR_LANGUAGE=ara+eng
PAPERLESS_OCR_LANGUAGES=ara
```
 
## Step 8: Start the application
 
On the VM:
 
```bash
cd ~/paperless
bash deploy.sh
bash health_check.sh
```
 
`webserver`, `db`, and `broker` must be `running`.
 
## Step 9: Open Paperless
 
Open in a browser from an allowed IP:
 
```text
http://<VM_PUBLIC_IP>:8000
```
 
Sign in, upload a test document, and check that it is processed and can be found by search.
 