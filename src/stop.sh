#!/bin/bash

echo "Bye, Runtime Local!"

DEPENDENCIES=$(cat $VELOCITAS_WORKSPACE_DIR/app/AppManifest.json | jq .[].dependencies)
SERVICES=$(echo $DEPENDENCIES | jq '.services')

if [ "$SERVICES" = "null" ];then
    echo "No Services defined in AppManifest. Skip stopping vehicle services.";
else
    readarray -t SERVICES_ARRAY < <(echo $SERVICES | jq -c '.[]')
    for service in ${SERVICES_ARRAY[@]}; do
        SERVICE_NAME=$(echo $service | jq '.name' | tr -d '"' )
        echo "Stopping Service: $SERVICE_NAME"
        dapr stop --app-id $SERVICE_NAME && docker rm -f local_$SERVICE_NAME
        fi
    done
fi

dapr stop --app-id vehicledatabroker && docker rm -f local_vehicledatabroker
dapr stop --app-id feedercan && docker rm -f local_feedercan
docker rm -f local_mosquitto
