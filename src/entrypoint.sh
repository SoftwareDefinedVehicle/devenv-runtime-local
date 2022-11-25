#!/bin/bash

echo "Hello, Runtime Local!"
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
LOG_DIR=$(dirname "$SCRIPT_DIR")/logs

if [ ! -d $LOG_DIR ]
    then mkdir -p $LOG_DIR
fi

${SCRIPT_DIR}/ensure-dapr.sh 2>&1 | awk '{print "runtime-local, ensure-dapr.sh, " $0}' >> ${LOG_DIR}/runtime-local.log
${SCRIPT_DIR}/run-feedercan.sh 2>&1 | awk '{print "runtime-local, run-feedercan.sh, " $0}' >> ${LOG_DIR}/runtime-local.log &
${SCRIPT_DIR}/run-mosquitto.sh 2>&1 | awk '{print "runtime-local, run-mosquitto.sh, " $0}' >> ${LOG_DIR}/runtime-local.log &
${SCRIPT_DIR}/run-vehicledatabroker.sh 2>&1 | awk '{print "runtime-local, run-vehicledatabroker.sh, " $0}' >> ${LOG_DIR}/runtime-local.log &
${SCRIPT_DIR}/run-vehicleservices.sh 2>&1 | awk '{print "runtime-local, run-vehicleservices.sh, " $0}' >> ${LOG_DIR}/runtime-local.log &
