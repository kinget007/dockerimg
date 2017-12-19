#!/bin/bash

NODE_CONFIG_JSON="/root/nodeconfig.json"
#appium -U$ANDROID_DEVICE --port=9000 --bootstrap-port=10000 --chromedriver-port=20000 --selendroid-port=30000 --log={} --log-timestamp --no-reset
CMD="xvfb-run appium -U$ANDROID_DEVICE --port=9000 --bootstrap-port=10000 --chromedriver-port=20000 --selendroid-port=30000 --chromedriverExecutable=/root/chromedrivers/${CHROMEDRIVER_VERSION}"

# if [ ! -z "$REMOTE_ADB" ]; then
#     /root/wireless_connect.sh
# fi

if [ ! -z "$CONNECT_TO_GRID" ]; then
  /root/generate_config.sh $NODE_CONFIG_JSON
  CMD+=" --nodeconfig $NODE_CONFIG_JSON"
fi

pkill -x xvfb-run

$CMD
