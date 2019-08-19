#!/bin/bash

export https_proxy='http://http-proxy-2.em.health.ge.com:9400'

flow_token="$1"
#flow_token='42e95e5a31e2b017f686da04287d777f'
subject="$2"
message="$3"

event_id="$4"
event_id=
trigger_id="$5"
trigger_name="$6" 
host_name="$7" 
IFS=: read -r -a subject_array <<< "$subject"
title="${event_id}: ${trigger_name} on ${host_name}"

status_color="" 
status_value=""


# Change message emoji depending on the subject - smile (RECOVERY/OK), frowning (PROBLEM), or ghost (for everything else)
recoversub='RECOVERY'
if [[ "$message" =~ ${recoversub} ]]; then
	status_color="green"
	status_value="RECOVERY"
elif [[ "$message" =~ 'OK' ]]; then
	status_color="green"
	status_value="RECOVERY"
elif [[ "$message" =~ "PROBLEM" ]]; then
	status_color="red"
	status_value="PROBLEM"
else
	status_color="yellow"
	status_value="UNKNOWN"
fi

#avatar for author:
#    \"avatar\": \"https://avatars.githubusercontent.com/u/3017123?v=3\"
#"${subject//\"/\\\"} ${title//\"/\\\"}\",

json="{
  \"flow_token\": \"${flow_token}\",
  \"event\": \"activity\",
  \"author\": {
    \"name\": \"zabbix-bot\"
  },
  \"title\": \"${subject}\",
  \"external_thread_id\": \"${subject_array[0]}\",
  \"thread\": {
    \"title\": \"${subject}\",
    \"body\": \"${message//\"/\\\"}\",
    \"status\": {
      \"color\": \"${status_color}\",
      \"value\": \"${status_value}\"
    }
  }
}"

curl -i -X POST -H "Content-Type: application/json" -d "${json}" https://api.flowdock.com/messages/

