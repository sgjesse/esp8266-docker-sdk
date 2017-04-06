#!/bin/bash

# Do we need --priviledged???

CONTAINER_NAME=esp8266-sdk
HOST_SHARE=$HOME/prj/share
CONTAINER_USER=esp8266
CONTAINER_HOME=/home/$CONTAINER_USER
CONTAINER_SHARE=$CONTAINER_HOME/share

# Currently Docker on Mac OS does not support serial devices
# SERIAL_DEVICE=/dev/tty.wchusbserial1420

# Remove the container with the selected name, if it already exists.
if [ $(docker ps --quiet --all --filter name=^/${CONTAINER_NAME}$) ]; then
  docker container rm $CONTAINER_NAME > /dev/null
fi

docker run \
  --tty \
  --interactive \
  --volume $HOST_SHARE:$CONTAINER_SHARE \
  --name $CONTAINER_NAME \
  -e "BIN_PATH=$CONTAINER_HOME/share/test/bin" \
  -e "SDK_PATH=$CONTAINER_HOME/share/ESP8266_RTOS_SDK" \
  --rm \
  sgjesse/esp-open-sdk \
  "$@"
