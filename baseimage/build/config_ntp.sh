#!/usr/bin/env bash

echo "Installing ntp run scripts."
mkdir -p /etc/service/ntp
cp /build/daemon/ntp.sh /etc/service/ntp/run
cp /build/config/ntp.conf /etc/ntp.conf
chmod +x /etc/service/ntp/run
