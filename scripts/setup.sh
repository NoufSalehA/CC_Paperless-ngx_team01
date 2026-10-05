 #in setup.sh file, we will install the required packages, configure the docker and download the paperless application to the VM

 #========================================================
 #1-package installation
 #1.1 get the public IP of the VM
az vm show -d -g paperless_rg -n paperless-vm --query publicIps -o tsv

#1.2 connect to the VM 
 ssh azureuser@20.91.226.81

#1.3 update and upgrade the packages on the VM
 sudo apt-get update && sudo apt-get upgrade -y

#1.4 install and run docker 
 curl -fsSL https://get.docker.com | sudo sh
#========================================================

#2- Docker setup
#2.1 add the user to the docker 
sudo usermod -aG docker $USER

#2.2 exit and reconnect to the VM to make sure the user is added to the docker 
exit
ssh azureuser@20.91.226.81

#2.3 check the docker version and docker compose version
docker --version
docker compose version

#========================================================
#3-runtime configuration
#3.1 creats a folder for the paperless application and navigate to it
 mkdir -p ~/paperless && cd ~/paperless

#3.2 download the paperless installation 
 bash -c "$(curl --location --silent --show-error https://raw.githubusercontent.com/paperless-ngx/paperless-ngx/main/install-paperless-ngx.sh)"
 
#3.3 download the postgres docker compose file and rename it to docker-compose.yml 
azureuser@paperless-vm:~/paperless$ wget https://raw.githubusercontent.com/paperless-ngx/paperless-ngx/main/docker/compose/docker-compose.postgres.yml -O docker-compose.yml

#3.4 download the docker-compose.env file 
wget https://raw.githubusercontent.com/paperless-ngx/paperless-ngx/main/docker/compose/docker-compose.env

#3.5 download the .env file
wget https://raw.githubusercontent.com/paperless-ngx/paperless-ngx/main/docker/compose/.env

#3.6 check the user and group id of the azureuser
id -u
id -g

#3.7  show the user and group ID
id "azureuser"

# 3.8 show the content of the docker-compose.env file
cat docker-compose.env 

#3.9 generate a random secret key to add it to the docker-compose.env file   
python3 -c "import secrets; print(secrets.token_urlsafe(64))"

#3.10 Edit the `docker-compose.env` file to add the secret key, change the country location to Riyadh, and uncomment the OCR language.
nano docker-compose.env 

  


