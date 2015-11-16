#!/usr/bin/env bash

source .config.sh
BASEFOLDER=$(pwd)

echo "Deleting all containers"
docker stop $(docker ps -a | awk '{print $1}') 2> /dev/null
docker rm $(docker ps -a | awk '{print $1}') 2> /dev/null

# Get Tags
IFS=', ' read -r -a array <<< "$IMAGES"

# For each tag
for IMAGE in "${array[@]}"
do
  IMAGENAME="$PREFIX/$IMAGE"

  IMAGEID=$(docker images | grep "$IMAGENAME" | awk '{print $3}')
  if [ ! -z $IMAGEID ]; then
    echo "Deleting old $IMAGENAME."
    docker rmi $IMAGEID 2> /dev/null

    if [ ! $? -eq 0 ]; then
      echo "Delete $IMAGENAME failed."
      exit 1
    fi
  fi

  if [ -e ./$IMAGE/Dockerfile ]; then
    cd ./$IMAGE
    echo "Build $IMAGENAME started."
    ID=$(docker build -t $IMAGENAME .)
    cd ..

    if [ $? -eq 0 ]; then
      docker tag $ID $IMAGENAME:latest 2> /dev/null
      echo "Build $IMAGENAME success"
    else
      echo "Build $IMAGENAME failed"
      exit 1
    fi
  fi

done
