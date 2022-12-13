#!/bin/bash
# Copyright (c) 2022 Robert Bosch GmbH and Microsoft Corporation
#
# This program and the accompanying materials are made available under the
# terms of the Apache License, Version 2.0 which is available at
# https://www.apache.org/licenses/LICENSE-2.0.
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
# WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
# License for the specific language governing permissions and limitations
# under the License.
#
# SPDX-License-Identifier: Apache-2.0

echo "#######################################################"
echo "### Running MQTT Broker                             ###"
echo "#######################################################"

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

MQTTBROKER_IMAGE=$(cat $SCRIPT_DIR/config.json | jq .mqttBroker.image | tr -d '"')
MQTTBROKER_TAG=$(cat $SCRIPT_DIR/config.json | jq .mqttBroker.version | tr -d '"')

#Terminate existing running services
RUNNING_CONTAINER=$(docker ps | grep "$MQTTBROKER_IMAGE" | awk '{ print $1 }')

if [ -n "$RUNNING_CONTAINER" ];
then
    docker container stop $RUNNING_CONTAINER
fi

docker container rm local_mosquitto 2>/dev/null

docker run --rm --name local_mosquitto -p 1883:1883 -p 9001:9001 $MQTTBROKER_IMAGE:$MQTTBROKER_TAG mosquitto -c /mosquitto-no-auth.conf
