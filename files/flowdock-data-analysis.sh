#!/bin/bash

set -x

export https_proxy='http://http-proxy-2.em.health.ge.com:80'

to="$1"
subject="$2"
message="$3"

content="${subject//\"/\\\"}: ${message//\"/\\\"}"

# Source token: 3107a5d737d97e5ca3f8710c1899cd4a
# Zabbix Application for Data Analysis Zabbix flow

json="{
  \"flow_token\": \"3107a5d737d97e5ca3f8710c1899cd4a\",
  \"event\": \"message\",
  \"content\": \"${content}\"
}"


curl --verbose -i -X POST -H "Content-Type: application/json" -d "${json}" https://api.flowdock.com/messages

