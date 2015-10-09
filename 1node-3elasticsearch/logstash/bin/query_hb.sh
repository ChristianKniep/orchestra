#!/bin/bash

export CURLOPT_DNS_CACHE_TIMEOUT=5

function logit {
   echo "${STAMP} ;; ${1}"|nc -w1 ${DHOST} 5514
}

cat << \EOF > payload
{
  "query": {
    "filtered": {
      "query": {
        "bool": {
          "should": [
            {
              "query_string": {
                "query": "*"
              }
            }
          ]
        }
      },
      "filter": {
        "bool": {
          "must": [
            {
              "range": {
                "@timestamp": {
                  "from": FROM000,
                  "to": TO000
                }
              }
            },
            {
              "fquery": {
                "query": {
                  "query_string": {
                    "query": "_type:(\"heartbeat\")"
                  }
                },
                "_cache": true
              }
            }
          ]
        }
      }
    }
  }
}
EOF
### 
while [ true ];do
    STAMP=$(date +"%H:%M:%S")
    now=$(date +%s)
    for offset in {5..35};do
        TO=$(echo ${now} - ${offset} + 1|bc)
        FROM=$(echo ${now} - ${offset}|bc)
        sed -i -e "s/\"from.*/\"from\": ${FROM}000,/" payload
        sed -i -e "s/\"to.*/\"to\": ${TO}000/" payload
        cnt=$(curl -s -XGET "http://es.elasticsearch.service.consul:9200/_all/_search?pretty" -d @payload | jq ".hits.total")
        if [ $? -ne 0 ];then
            logit "curl http://es.elasticsearch.service.consul:9200 failed..."
            break
        fi
        msg=$(echo "es.heartbeat.cnt ${cnt} ${TO}")
        #echo ${msg}
        echo ${msg} | nc -w1 carbon.service.consul 2003
    done
    sleep 9
done
