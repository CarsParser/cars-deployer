#!/bin/bash
source helpers.sh

log "${GREEN} Logging to docker repo ${CLOSE}"
docker login -u "$CI_REPOSITORY_NAME" -p "$CI_REPOSITORY_PASSWORD"

log "${GREEN} Pulling last image version"
docker pull blakexxxd/cars-backend:latest
docker pull blakexxxd/avito-parse:latest

docker stack deploy -c stack/app/stack.yml app-stack