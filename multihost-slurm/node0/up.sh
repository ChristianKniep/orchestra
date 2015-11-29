#!/bin/bash

docker-compose up -d consul
sleep 1
consul_ip=$(docker inspect -f '{{ .NetworkSettings.Networks.global.IPAddress }}' consul)
echo "Consul IP: ${consul_ip}"
export CONSUL_IP=${consul_ip}

docker-compose up -d
