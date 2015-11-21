#!/usr/bin/env bash
IMAGE="$1"
PREFIX="platinmarket"
BASEFOLDER=$(pwd)
IMAGENAME="$PREFIX/$IMAGE"

if [ ! -e ./$IMAGE/Dockerfile ]; then
  echo "Dockerfile /$IMAGE/Dockerfile not found."
  exit 1
fi

echo "Deleting existing $IMAGENAME containers."
docker stop $(docker ps -a | grep "$IMAGENAME " | awk '{print $1}') 2> /dev/null
docker rm $(docker ps -a | grep "$IMAGENAME " | awk '{print $1}') 2> /dev/null

IMAGEID=$(docker images | grep "$IMAGENAME " | awk '{print $3}')
if [ ! -z $IMAGEID ]; then
  echo "Deleting existing $IMAGENAME images."
  docker rmi $IMAGEID 2> /dev/null

  if [ ! $? -eq 0 ]; then
    echo "Delete failed."
    exit 1
  fi
fi

cd ./$IMAGE
echo "Build $IMAGENAME started."
docker build -t "$IMAGENAME" . 2> /dev/null
cd ..

if [ $? -eq 0 ]; then
  echo "Build $IMAGENAME success."
  exit 0
else
  echo "Build $IMAGENAME failed."
  exit 1
fi
