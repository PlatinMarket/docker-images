#!/usr/bin/env bash
echo "Updating."

# Update OS
apt-get update && apt-get -y upgrade

# Update var/www
sh /config/git_pull.sh
