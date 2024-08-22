#!/bin/bash

script_dir=$(dirname $(readlink -f $0))
webhook_url=$(cat ${script_dir}/credentials/urls.json |jq -r '.url')

send_message(){
    local msg=$1
    local tmp='{"text": "__MESSAGE__"}'
    local payload=$(echo ${tmp} | sed -e "s/__MESSAGE__/${msg}/")    
    curl -X POST -H "Content-type: application/json" -d "${payload}" ${webhook_url}
}

try_connect(){
    local target_ip=$1
    local timeout=$2
    ping -c1 -W${timeout} ${target_ip}
    return $?
}

target_ip=10.0.0.2
timeout=1

for i in {1..3}; do
    try_connect ${target_ip} ${timeout}
    result=$?
    if [[ ${result} = 0 ]]
    then
        echo success
        send_message "success"
        exit 0
    else
        echo error. trial: ${i}
    fi
done

send_message "error <@hotoku>"
