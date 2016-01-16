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
echo "[server]        > docker-compose up -d server                  > Start"
docker-compose up -d server
echo "[server]        > docker network connect global server         > Connect to global network"
docker network connect global server
sleep 2
echo "[server]        > docker exec -ti server  ip -o -4 addr        > Display ip addresses"
docker exec -ti server  ip -o -4 addr
echo "[client]        > docker-compose up -d client                  > Start"
docker-compose up -d client
echo "[load-balancer] > docker-compose up -d load-balancer           > Start"
docker-compose up -d load-balancer
echo "[load-balancer] > docker network connect global load-balancer  > Connect to global network"
docker network connect global load-balancer
sleep 5
echo "[load-balancer] > docker exec -ti load-balancer  ip -o -4 addr > Display ip addresses"
docker exec -ti load-balancer  ip -o -4 addr
echo "[www1]    > docker-compose up -d www1                          > Start"
docker-compose up -d www1
echo "[www2]    > docker-compose up -d www2                          > Start"
docker-compose up -d www2
sleep 3
echo "[client]    > docker-compose up -d client                      > Start"
docker-compose up -d client
echo "[CONSUL]  > docker exec -ti server consul members              > Show members of DC1"
docker exec -ti server consul members
