#!/bin/bash

script_dir=$(dirname $(readlink -f $0))
webhook_url=$(cat ${script_dir}/credentials/urls.json |jq -r '.url')

send_message(){
    local msg=$1
    local tmp='{"text": "__MESSAGE__"}'
    local payload=$(echo ${tmp} | sed -e "s/__MESSAGE__/${msg}/")    
    curl -X POST -H "Content-type: application/json" -d "${payload}" ${webhook_url}
}


timeout=1
target_ip=10.0.0.2
ping -c1 -W${timeout} ${target_ip}

result=$?

if [[ ${result} = 0 ]]
then
    echo success
    send_message "success"
else
    echo error
    send_message "error <@hotoku>"
fi
