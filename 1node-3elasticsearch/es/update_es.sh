#!/bin/bash

function logit {
   echo "${1}"|nc -w1 ${DHOST} 5514
}

function wait_es {
    # wait for es to come up
    if [ $(curl -s ${DHOST}:921${1}|grep status|grep -c 200) -ne 1 ];then
        sleep 1
        wait_es
    else
        echo "$(date +'%F %H:%M:%S') > Elasticsearch return status 200 -> good to go"
        loggit "es${1} returns 200 again"
    fi
}

ping -c1 ${DHOST} >/dev/null
if [ $? -ne 0 ];then
    echo "Not able to ping DHOST: '${DHOST}'"
    exit 1
fi
echo "Which instance should I shutdown? (0/1/2) \c"
read inst

echo "Shutdown ES instance es${inst}: curl -s -XPOST 'http://${DHOST}:921${inst}/_cluster/nodes/_local/_shutdown'"
logit "es${inst} shutdown"
curl -s -XPOST "http://${DHOST}:921${inst}/_cluster/nodes/_local/_shutdown"|jq .
sleep 5
echo "kill instance: docker-compose kill es${inst}; docker-compose rm --force"
logit "es${inst} removal"
docker-compose kill es${inst}; docker-compose rm --force
sleep 2
echo "start new instance: docker-compose up -d es${inst}"
logit "es${inst} start"
docker-compose up -d es${inst}
wait_es ${inst}
