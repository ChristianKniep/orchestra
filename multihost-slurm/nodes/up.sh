#!/bin/bash

echo -n "Which SUFFIX should we provide fd20_x? "
read cnt

if [ -z $CONSUL_IP ];then
    echo -n "Please provide the IP under which the consul master could be found? "
    read consul_ip
    export CONSUL_IP=${consul_ip}
fi

set -x
CNT=${cnt} docker-compose up -d
