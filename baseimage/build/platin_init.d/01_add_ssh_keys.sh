#!/usr/bin/env bash

# Get Tags
IFS=', ' read -r -a array <<< "$TAG"

# For each tag
for tag in "${array[@]}"
do
  if [ -e $BASEFOLDER/$tag/authorized_keys/*.pub ]; then
    echo "Adding authorized ssh keys from $BASEFOLDER/$tag/authorized_keys."
    echo "" > /root/.ssh/authorized_keys
    cat $BASEFOLDER/$tag/authorized_keys/*.pub >> /root/.ssh/authorized_keys
  fi
done
