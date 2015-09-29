#!/bin/bash

set -x 
curl -s localhost:8500/v1/catalog/service/isc0 | jq .


