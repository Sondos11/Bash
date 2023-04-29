#!/bin/bash

#1//

num1=4.5
num2=2.3
scale=2
result=$(echo "$num1*$num2" | bc)
echo $result

#2//

num=1.5
if echo "$num" | grep -qE '^[-+]?[0-9]*\.?[0-9]+([eE][-+]?[0-9]+)?$';
then
   echo "$num is a valid floating point"
else
   echo $num "is not a valid floating point"
fi

#3//

if [[ $(id -u) -ne 0 ]]; then
    echo "The user is not the root "
    exit 1
fi

while true; do
   load=$(uptime | awk '{print $10}')
   datetime=$(date '+%Y-%m-%d %H:%M:%S')
   echo "$datetime $load" >> /var/log/system-load
   sleep 60
done
