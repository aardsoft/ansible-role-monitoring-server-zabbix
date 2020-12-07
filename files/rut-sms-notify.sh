#!/bin/bash
# rut-sms-notify.sh

host="$1"
user="$2"
pass="$3"
number="$4"
subject="$5"
message="$6"
host_name="$7"
event_id="$8"
trigger_id="$9"
trigger_name="$10"

m="$subject
.

$message

Host: $host_name
Event ID: $event_id
Trigger ID: $trigger_id
Trigger name: $trigger_name"

curl -G -X GET \
     --data-urlencode "username=$user" \
     --data-urlencode "password=$pass" \
     --data-urlencode "number=$number" \
     --data-urlencode "text=$m" \
     "http://$host/cgi-bin/sms_send"
