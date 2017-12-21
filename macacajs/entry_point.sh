#!/bin/bash

if [ ! -z "$REMOTE_ADB" ]; then

    if [ -z "$REMOTE_ADB_POLLING_SEC" ]; then
        REMOTE_ADB_POLLING_SEC=10
    fi

    #to avoid immediate run
    sleep ${REMOTE_ADB_POLLING_SEC}

    if [ ! -z "$ANDROID_DEVICE" ]; then
      echo "Connecting to: ${ANDROID_DEVICE}"
      adb connect ${ANDROID_DEVICE}
      device=$(adb devices | grep -E -o "[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}:[0-9]+")
      echo "Devices found: ${device}"
      echo "Success!"
    fi
fi

CMD="xvfb-run bin/nosmoke -h /root/scripts/hook.js -c /root/scripts/config.yml"
pkill -x xvfb-run

$CMD
