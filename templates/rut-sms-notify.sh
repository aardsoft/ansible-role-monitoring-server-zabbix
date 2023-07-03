#!/bin/bash
# rut-sms-notify.sh

host="$1"
user="$2"
pass="$3"
number="$4"
subject="$5"
message="$6"

m="$subject

$message"

curl -G -X GET \
     --data-urlencode "username=$user" \
     --data-urlencode "password=$pass" \
     --data-urlencode "number=$number" \
     --data-urlencode "text=$m" \
     "http://$host/cgi-bin/sms_send"
