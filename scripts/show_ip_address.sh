#!/bin/bash
dev='$1'
ip addr show $dev | awk '/inet/ {print $2}' | cut -d/ -f1
