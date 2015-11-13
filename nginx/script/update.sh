#!/usr/bin/env bash
echo "Updating OS."

# Update OS
apt-get update && apt-get -y upgrade

# Update var/www
sh /config/git_pull.sh
