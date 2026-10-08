# Daily Operations
 
## Part 1: Admin
 
### Daily check
 
1. Sign in to Azure:
```bash
   az login
```
2. Connect to the VM:
```bash
   ssh azureuser@<VM_PUBLIC_IP>
```
3. Go to the application folder:
```bash
   cd ~/paperless
```
4. Start the services (if they are not running):
```bash
   docker compose up -d
```
 
### Add a new user device
1. Get the user's public IP (the user finds it as shown in Part 2).
2. On your computer, open `terraform/terraform.tfvars` and add the IP to `allowed_web_cidrs`:
```hcl
   allowed_web_cidrs = [
     "203.0.113.10/32",
     "203.0.113.55/32",   # new user
   ]
```

3. Apply the change:
```bash
   cd <peoject_folder_name > 
   cd terraform
   az login
   terraform apply
```

4. Terraform asks for `admin_password`. Enter **the same VM password** you used at deployment.
   
5. Type `yes`, then tell the user they can now sign in.


### Create a Paperless account for a user
1. Open `http://<VM_PUBLIC_IP>:8000` and sign in as admin.
2. Go to **Settings > Users & Groups**.
3. Click **Create**, enter the username and password, and choose the group.


## Part 2: Regular Users
1. Find your public IP and send it to the admin:
```bash
   curl -4 ifconfig.me
```
   (Windows PowerShell: `curl.exe -4 ifconfig.me`)
2. Wait until the admin confirms that your IP was added.
3. Open the system in your browser:
```text
   http://<VM_PUBLIC_IP>:8000
```
4. Sign in with the account the admin gave you.
5. Upload documents and search for them.

If your network changes (for example a different Wi-Fi), your IP changes too. Repeat step 1.