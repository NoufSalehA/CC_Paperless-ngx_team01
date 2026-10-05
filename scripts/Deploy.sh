#Validate the docker compose configuration file
docker compose config

#download the required application images to the VM
docker compose pull     

#application startup
docker compose up -d
