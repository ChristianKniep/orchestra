#!/bin/bash

set -ex

RKTHOST=$(echo $DOCKER_HOST |egrep -o "\d+\.\d+\.\d+\.\d+") docker-compose up -d rc-consul mongodb
sleep 5
RKTHOST=$(echo $DOCKER_HOST |egrep -o "\d+\.\d+\.\d+\.\d+") docker-compose up -d rocketchat carbon gapi grafana
sleep 30
RKTHOST=$(echo $DOCKER_HOST |egrep -o "\d+\.\d+\.\d+\.\d+") docker-compose up -d

