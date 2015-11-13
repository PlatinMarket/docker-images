#!/usr/bin/env bash

if [ -e $TOOLBOXFOLDER ]; then
  # Get Tags
  IFS=', ' read -r -a array <<< "$TAG"

  # For each tag
  for tag in "${array[@]}"
  do
    if [ -e $BASEFOLDER/$tag/hosts ]; then
      echo "Adding hosts file from $BASEFOLDER/$tag/hosts."
      cat $BASEFOLDER/$tag/hosts | while read line
      do
        toolbox add_host $line
      done
    fi
  done
fi
