#!/bin/bash

echo "Hello, Runtime Local!"

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
if [ ! -d ../logs ]
  then mkdir ../logs
fi
${SCRIPT_DIR}/ensure-dapr.sh >> ../logs/ensure-dapr.log 2>> ../logs/ensure-dapr.log
${SCRIPT_DIR}/run-feedercan.sh >> ../logs/run-feedercan.log 2>&1
${SCRIPT_DIR}/run-mosquitto.sh >> ../logs/run-mosquitto.log 2>&1
${SCRIPT_DIR}/run-vehicledatabroker.sh >> ../logs/run-vehicledatabroker.log 2>&1
${SCRIPT_DIR}/run-vehicleservices.sh >> ../logs/run-vehicleservices.log 2>&1
