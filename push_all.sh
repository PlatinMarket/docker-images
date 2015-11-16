#!/usr/bin/env bash

source .config.sh
BASEFOLDER=$(pwd)

# Get Tags
IFS=', ' read -r -a array <<< "$IMAGES"

# For each tag
for IMAGE in "${array[@]}"
do
  IMAGENAME="$PREFIX/$IMAGE"

  IMAGEID=$(docker images | grep "$IMAGENAME" | awk '{print $3}')
  if [ -z $IMAGEID ]; then
    echo "Build $IMAGENAME first."
    exit 1
  fi

  echo "Deleting $IMAGENAME containers."
  docker stop $(docker ps -a | grep "$IMAGENAME" | awk '{print $1}') 2> /dev/null
  docker rm $(docker ps -a | grep "$IMAGENAME" | awk '{print $1}') 2> /dev/null

  IMAGEID=$(docker run -d $IMAGENAME)
  if [ -z $IMAGEID ]; then
    echo "Run $IMAGENAME failed."
    exit 1
  fi

  echo "Committing $IMAGENAME changes."
  docker commit -m "Several updates" $IMAGEID 2> /dev/null

  if [ ! $? -eq 0 ]; then
    echo "Commit $IMAGENAME failed."
    exit 1
  fi

  echo "Pushing $IMAGENAME."
  docker push $IMAGENAME
  docker stop $IMAGEID 2> /dev/null
  docker rm -f $IMAGEID 2> /dev/null

  if [ ! $? -eq 0 ]; then
    echo "Push $IMAGENAME failed."
    exit 1
  fi

done
