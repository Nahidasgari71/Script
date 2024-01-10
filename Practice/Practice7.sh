#!/bin/bash

V_TODAY=date +%Y%m%d-%H:%M:%S
V_IPS="/home/nahid_a/script/ips"
V_DST="/home/nahid_a/script/output_${HOSTNAME}_${V_TODAY}.log"

while IFS=: read -r V_HOSTNAME V_IP; do
    if ping -c 1 "$V_IP" > /dev/null; then
        echo " $V_HOSTNAME ($V_IP): Ping is  successful" >> "$V_DST"
    else
        echo " $V_HOSTNAME ($V_IP): Ping is  failed" >> "$V_DST"
    fi
done < "$V_IPS"
