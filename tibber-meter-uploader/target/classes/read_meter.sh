#!/bin/bash

HA_BASE_URL="http://supervisor/core/api" # Ersetze durch die URL des Home Assistant REST API-Proxys

response=$(curl -s -X GET "${HA_BASE_URL}/states/sensor.stromzahler")

date_part=$(echo $response | /usr/bin/jq -r '.last_changed[:10]')
meter_part=$(echo $response | /usr/bin/jq -r '.state | tonumber | floor')

meter_reading="${date_part} ${meter_part}"

echo "$meter_reading"
