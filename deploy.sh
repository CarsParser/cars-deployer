#!/bin/bash
source helpers.sh

docker swarm init

if [[ $(docker network ls | grep "app") = "" ]]; then
    log "${GREEN} Creating app network ${CLOSE}"
    docker network create --opt encrypted -d overlay --attachable app
else
    log "${YELLOW} Network app already exists ${CLOSE}"
fi

log "${GREEN} Deploying app ${CLOSE}"
docker stack deploy -c stack/selenium/stack.yml app-selenium-stack
docker stack deploy -c stack/db/stack.yml app-db-stack
#docker stack deploy -c stack/elk/stack.yml elk-stack