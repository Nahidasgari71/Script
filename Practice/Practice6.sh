#!/bin/bash

USERNAME=$USER

DATE=date

WHO=$(who | wc -l)

echo "Welcome to $HOSTNAME todaye is $DATE"
echo "Number of users already logged in : $WHO"
