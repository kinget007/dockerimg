#!/bin/bash

NODE_CONFIG_JSON="/root/nodeconfig.json"
#appium -U$ANDROID_DEVICE --port=9000 --bootstrap-port=10000 --chromedriver-port=20000 --selendroid-port=30000 --log={} --log-timestamp --no-reset
CMD="xvfb-run appium -U$ANDROID_DEVICE --port=9000 --bootstrap-port=10000 --chromedriver-port=20000 --selendroid-port=30000 --chromedriver-executable=/root/chromedrivers/${CHROMEDRIVER_VERSION}"

if [ ! -z "$REMOTE_ADB" ]; then

    if [ -z "$REMOTE_ADB_POLLING_SEC" ]; then
        REMOTE_ADB_POLLING_SEC=10
    fi

    function connect() {
        while true
        do
            #to avoid immediate run
            sleep ${REMOTE_ADB_POLLING_SEC}
            if [! -z "$ANDROID_DEVICE" ]; then
              echo "Connecting to: ${ANDROID_DEVICE}"
              #to avoid immediate run
              sleep ${REMOTE_ADB_POLLING_SEC}
              adb connect ${ANDROID_DEVICE}
              device=$(adb devices)
              echo "Devices found: ${device}"
              echo "Success!"
            fi
        done
    }

    ( trap "true" HUP ; connect ) >/dev/null 2>/dev/null </dev/null & disown
fi

if [ ! -z "$CONNECT_TO_GRID" ]; then
  /root/generate_config.sh $NODE_CONFIG_JSON
  CMD+=" --nodeconfig $NODE_CONFIG_JSON"
fi

pkill -x xvfb-run >/dev/null 2>/dev/null </dev/null

$CMD
