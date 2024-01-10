#!/bin/bash

for ((i=1;i<=20;i++))
do
   read -p "please enter number $i :" NUM

   if [ $i -eq 1 ];then

MAX=$NUM
MIN=$NUM

else

 if [ $NUM -gt $MAX ]
then

MAX=$NUM

 elif [ $NUM -lt $MIN ]
then

MIN=$NUM
 fi
fi
done
printf  "Max num is: %d\n" "$MAX"
printf "Min num is: %d\n" "$MIN"
