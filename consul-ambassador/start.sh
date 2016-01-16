#!/bin/bash

echo "## Networks"
echo "[global] > docker network inspect global >/dev/null                        > exists?"
docker network inspect global >/dev/null
if [ $? -ne 0 ];then
    echo "[global] > docker network create -d bridge --subnet=10.0.0.0/24 global > create"
    docker network create -d bridge --subnet=10.0.0.0/24 global
else
    SUB=$(docker network inspect global |jq ".[0].IPAM.Config[0].Subnet")
    echo "[global] > already there (SUB: ${SUB})"
fi
echo "[int] > docker network inspect int >/dev/null                              > exists?"
docker network inspect int >/dev/null
if [ $? -ne 0 ];then
    echo "[int] > docker network create -d bridge --subnet=192.168.1.0/24 int     > create"
    docker network create -d bridge --subnet=192.168.1.0/24 int
else
    SUB=$(docker network inspect int |jq ".[0].IPAM.Config[0].Subnet")
    echo "[int] > already there (SUB: ${SUB})"
fi
echo "#### Start stack"
echo "[server]         > docker-compose up -d server                  > Start"
docker-compose up -d server
echo "[server]         > docker network connect int server            > Connect to int network"
docker network connect int server
sleep 2
echo "[server]         > docker exec -ti server  ip -o -4 addr        > Display ip addresses"
docker exec -ti server  ip -o -4 addr
echo "[ext0,int{1..3}] > docker-compose up -d ext0 int1 int2 int3     > Start"
docker-compose up -d ext0  int1 int2 int3
