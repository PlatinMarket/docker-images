#!/bin/bash
name="$1"

if [ -z "$name" ]; then
  echo "Usage: remove_host [Hostname OR IpAddress]"
  exit 1
fi

cat /etc/hosts | sed -n "/$name/!p" > /etc/hosts_temp 2> /dev/null
cp /etc/hosts /etc/hosts_bak 2> /dev/null
mv /etc/hosts_temp /etc/hosts 2> /dev/null

if [ $? -eq 0 ]; then
    echo "Done"
    exit 0
else
    echo "Fail"
    exit 1
fi
