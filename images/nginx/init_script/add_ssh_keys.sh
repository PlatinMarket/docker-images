#!/usr/bin/env bash
echo "Adding authorized ssh keys."
echo "" > /root/.ssh/authorized_keys
if [ -f /config/authorized_keys/*.pub ]; then
  cat /config/authorized_keys/*.pub >> /root/.ssh/authorized_keys
fi
