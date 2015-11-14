#!/usr/bin/env bash

# Get Tags
IFS=', ' read -r -a array <<< "$TAG"

# For each tag
for tag in "${array[@]}"
do
  # checking sites-enabled dir
  if [ -e $BASEFOLDER/$tag/sites-enabled ]; then
    echo "Adding sites-enabled files from $BASEFOLDER/$tag/sites-enabled to /etc/sites-enabled"
    cp -rf $BASEFOLDER/$tag/sites-enabled/* /etc/sites-enabled
  fi
done

# Restart nginx service, if it exists.
if [ -e /etc/service/nginx/run ]; then
  echo "Reloading nginx."
  service nginx reload
fi
