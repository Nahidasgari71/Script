#!/bin/bash

V_TODAY=date +%Y%m%d

V_DST="/home/nahid_a/script/test/output_${HOSTNAME}_${V_TODAY}.txt"

awk -F: '{print $1, $3}' /etc/passwd > "$V_DST"

find /home/nahid_a/script/test/output/ -name "output_*" -mtime +2 -exec rm {} \;
