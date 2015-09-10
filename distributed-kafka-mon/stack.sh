#!/bin/bash

if [ "X$1" == "Xup" ];then
    docker-compose -f ${COMPOSE_FILE} up -d consul
    sleep 2
    docker-compose -f ${COMPOSE_FILE} up -d registrator
    sleep 1
    docker-compose -f ${COMPOSE_FILE} up -d vmConsul
elif [ "X$1" == "Xdown" ];then
    echo -n "Do you really want to tear down the stack? (y/N) "
    read inp
    if [ "X${inp}" == "Xy" ];then
         docker-compose -f ${COMPOSE_FILE} kill
         docker-compose -f ${COMPOSE_FILE} rm --force
    fi
fi
