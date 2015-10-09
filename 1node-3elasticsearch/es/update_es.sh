#!/bin/sh


STAMP=$(date +"%H:%M:%S")

function logit {
   echo "${STAMP} ;; ${1}"|nc -w1 ${DHOST} 5514
}

function wait_es {
    # wait for es to come up
    if [ $(curl -s ${DHOST}:921${1}|grep status|grep -c 200) -ne 1 ];then
        sleep 1
        wait_es ${1}
    else
        echo "$(date +'%F %H:%M:%S') > Elasticsearch return status 200 -> good to go"
        logit "es${1} returns 200 again"
    fi
}

ping -c1 ${DHOST} >/dev/null
if [ $? -ne 0 ];then
    echo "Not able to ping DHOST: '${DHOST}'"
    exit 1
fi

es_ver=$(egrep "image\:.*elasticsearch:[0-9\.]+$" base.yml|egrep -o '[0-9\.]+$')
for cont in $(docker-compose ps|grep "^es"|awk '{print $1}'|xargs);do
    if [ "X${cur_ver}" != "X" ];then
        echo " | \c"
    fi
    cur_ver=$(docker inspect -f '{{ .Config.Image }}' ${cont}|egrep -o '[0-9\.]+$')
    echo "${cont}:ES-v${cur_ver}\c"
done
echo ""
echo "Which instance should I shutdown? (0/1/2) \c"
read inst
cur_ver=$(docker inspect -f '{{ .Config.Image }}' es_es${inst}_1|egrep -o '[0-9\.]+$')
if [ "X${es_ver}" == "X${cur_ver}" ];then
   echo "C'mon, the current '${cur_ver}' and the new version '${es_ver}' is the same... you are sure? Proceed? [Y/n] \c"
else
   echo "Current container runs version '${cur_ver}', new instance will use '${es_ver}'. Proceed? [Y/n] \c"
fi
read go
if [ "X${go}" == "Xn" ];then
   echo " ABORT!"
   exit 0
fi

echo "Shutdown ES instance es${inst}: curl -s -XPOST 'http://${DHOST}:921${inst}/_cluster/nodes/_local/_shutdown'"
logit "es${inst} shutdown ;; curl -s -XPOST 'http://${DHOST}:921${inst}/_cluster/nodes/_local/_shutdown'"
logit $(curl -s -XPOST "http://${DHOST}:921${inst}/_cluster/nodes/_local/_shutdown")
sleep 5
echo "kill instance: docker-compose kill es${inst}; docker-compose rm --force"
logit "es${inst} removal ;; docker-compose kill es${inst}; docker-compose rm --force"
docker-compose kill es${inst}; docker-compose rm --force
logit "es${inst} removal ;; done"
sleep 2
echo "start new instance: docker-compose up -d es${inst}"
logit "es${inst} start ;; docker-compose up -d es${inst}"
docker-compose up -d es${inst}
logit "es${inst} wait for es to return 200"
wait_es ${inst}
