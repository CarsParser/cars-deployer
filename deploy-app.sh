#!/bin/bash
source helpers.sh

log "${GREEN} Logging to docker repo ${CLOSE}"
docker login -u "$CI_REPOSITORY_NAME" -p "$CI_REPOSITORY_PASSWORD"

log "${GREEN} Pulling last image version"
docker pull blakexxxd/cars-backend:latest

log "${GREEN} Begin creating topics"
docker exec $(docker ps -q -f name=kafka | tail -n1) /opt/kafka/bin/kafka-topics.sh --list --zookeeper zookeeper:2181
docker exec $(docker ps -q -f name=kafka | tail -n1) /opt/kafka/bin/kafka-topics.sh --create --if-not-exists --zookeeper zookeeper:2181 --partitions 1 --replication-factor 1 --topic load_cars
docker exec $(docker ps -q -f name=kafka | tail -n1) /opt/kafka/bin/kafka-topics.sh --create --if-not-exists --zookeeper zookeeper:2181 --partitions 10 --replication-factor 1 --topic cars_notification
docker exec $(docker ps -q -f name=kafka | tail -n1) /opt/kafka/bin/kafka-topics.sh --list --zookeeper zookeeper:2181
log "${GREEN} Done creating topics"

docker stack deploy -c stack/app/stack.yml app-stack