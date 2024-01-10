#!/bin/bash

V_=10

read -p "please enter your number:" NUM

 if [ $NUM -gt $V_ ]; then

 echo "This Number is greater than $V_"

elif [ $NUM -lt $V_ ];then

 echo " This Number is smaller than $V_"

else
        echo "This  Number is equal"
 fi
