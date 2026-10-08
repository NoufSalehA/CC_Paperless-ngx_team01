# Troubleshooting
 
## Find the problem
 
1. Connect to the VM:
```bash
   az login
   ssh azureuser@<VM_PUBLIC_IP>
   cd ~/paperless
```
2. Check which services are running:
```bash
   docker compose ps
```
3. Read the logs of the application:
```bash
   docker compose logs
```
 
If you cannot connect to the VM or the web page at all, your public IP is probably not in `allowed_web_cidrs`. Add it in `terraform.tfvars` and run `terraform apply` (steps are in "Add a new user device" in `daily_operations.md`).
 
## After fixing the problem
 
1. Redeploy:
```bash
   docker compose up -d
```
2. Open `http://<VM_PUBLIC_IP>:8000`.
 