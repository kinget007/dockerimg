#!/bin/bash

NODE_CONFIG_JSON="/root/nodeconfig.json"
#appium -U$ANDROID_DEVICE --port=9000 --bootstrap-port=10000 --chromedriver-port=20000 --selendroid-port=30000 --log={} --log-timestamp --no-reset
CMD="xvfb-run appium -U$ANDROID_DEVICE --port=9000 --bootstrap-port=10000 --chromedriver-port=20000 --selendroid-port=30000 --log=/root/appium.log  --log-level=error --chromedriver-executable=/root/chromedrivers/${CHROMEDRIVER_VERSION}/chromedriver"

if [ ! -z "$REMOTE_ADB" ]; then

    if [ -z "$REMOTE_ADB_POLLING_SEC" ]; then
        REMOTE_ADB_POLLING_SEC=5
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

if [ ! -z "$CONNECT_TO_GRID" ]; then
  /root/generate_config.sh $NODE_CONFIG_JSON
  CMD+=" --nodeconfig $NODE_CONFIG_JSON "
fi

pkill -x xvfb-run

$CMD
