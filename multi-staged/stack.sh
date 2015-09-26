#!/bin/bash

CONTAINER="consul backend middleware frontend"
if [ "X${1}" == "Xdown" ];then
    CONTAINER=$(echo ${CONTAINER}|xargs -n1|tail -r|xargs)
fi
for dir in ${CONTAINER};do
    pushd ${dir} >/dev/null
    echo -n "### ${dir}: "
    if [ "X${1}" == "Xup" ];then
        echo "docker-compose up -d "
        docker-compose up -d
    elif [ "X${1}" == "Xdown" ];then
        echo "docker-compose kill ; docker-compose rm --force"
        docker-compose kill ; docker-compose rm --force
    else
        echo "nothing done [up/down]"
    fi
    popd >/dev/null
done
