#!/bin/bash
ip="$1"
hostname="$2"

if [ -z "$ip" ] || [ -z "$hostname" ]; then
  echo "Usage: add_host [IpAddress] [Hostname]"
  exit 1
fi

cat /etc/hosts | sed -n "/$ip/!p" > /etc/hosts_temp
echo -e "$ip\t$hostname" >> /etc/hosts_temp
cp /etc/hosts /etc/hosts_bak
mv /etc/hosts_temp /etc/hosts
echo "Done"
