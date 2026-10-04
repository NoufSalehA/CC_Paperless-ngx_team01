 
az vm show -d -g paperless_rg -n paperless-vm --query publicIps -o tsv
 ssh azureuser@20.91.226.81
 sudo apt-get update && sudo apt-get upgrade -y
 curl -fsSL https://get.docker.com | sudo sh
sudo usermod -aG docker $USER
exit
ssh azureuser@20.91.226.81
docker --version
docker compose version
 mkdir -p ~/paperless && cd ~/paperless
 bash -c "$(curl --location --silent --show-error https://raw.githubusercontent.com/paperless-ngx/paperless-ngx/main/install-paperless-ngx.sh)"
 
azureuser@paperless-vm:~/paperless$ wget https://raw.githubusercontent.com/paperless-ngx/paperless-ngx/main/docker/compose/docker-compose.postgres.yml -O docker-compose.yml
 wget https://raw.githubusercontent.com/paperless-ngx/paperless-ngx/main/docker/compose/docker-compose.env
 wget https://raw.githubusercontent.com/paperless-ngx/paperless-ngx/main/docker/compose/.env
  wget https://raw.githubusercontent.com/paperless-ngx/paperless-ngx/main/docker/compose/.env
  id -o
  id -g
  id "azureuser"
  docker compose pull
  docker compose up -d
  cat docker-compose.env 
  python3 -c "import secrets; print(secrets.token_urlsafe(64))"
  nano docker-compose.env 
  docker compose config
  docker compose pull
  docker compose up -d
  


