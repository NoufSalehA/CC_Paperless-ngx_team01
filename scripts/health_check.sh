# in health_check.sh, we will check the health of the paperless application and provide troubleshooting and redeploy actions if needed. 

#1-health validation
docker compose ps

#2-troubleshooting and redeploy actions
docker compose logs     #for troubleshooting
docker compose up -d    #for redeploying