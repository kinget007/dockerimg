#!/bin/bash

node_config_json=$1

if [ -z "$PLATFORM_NAME" ]; then
  PLATFORM_NAME="Android"
fi

if [ -z "$APPIUM_HOST" ]; then
  APPIUM_HOST="127.0.0.1"
fi

if [ -z "$APPIUM_PORT" ]; then
  APPIUM_PORT=4723
fi

if [ -z "$SELENIUM_HOST" ]; then
  SELENIUM_HOST="127.0.0.1"
fi

if [ -z "$SELENIUM_PORT" ]; then
  SELENIUM_PORT=4444
fi

if [ -z "$BROWSER_NAME" ]; then
  BROWSER_NAME="chrome"
fi

if [ -z "$NODE_TIMEOUT" ]; then
  NODE_TIMEOUT=300
fi

if [ -z "$OS_VERSION" ]; then
  OS_VERSION=x.x
fi

#Get device names
# devices=($(adb devices | grep -E -o "[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}.[0-9]:[0-9]+"))
device=$(adb devices | grep -E -o "[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}:[0-9]+")
echo "Devices found: ${device}"

#Final node configuration json string
nodeconfig=$(cat <<_EOF
{
  "capabilities": [
  {
      "platform": "${PLATFORM_NAME}",
      "platformName": "${PLATFORM_NAME}",
      "version": "${OS_VERSION}",
      "browserName": "${BROWSER_NAME}",
      "deviceName": "${device}",
      "maxInstances": 1,
      "applicationName": "${DEVICE_SERIAL}"
    }
  ],
  "configuration": {
    "cleanUpCycle": 2000,
    "browserTimeout": 60,
    "timeout": $NODE_TIMEOUT,
    "proxy": "org.openqa.grid.selenium.proxy.DefaultRemoteProxy",
    "url": "http://$APPIUM_HOST:$APPIUM_PORT/wd/hub",
    "host": "$APPIUM_HOST",
    "port": $APPIUM_PORT,
    "maxSession": 6,
    "register": true,
    "registerCycle": 5000,
    "hubHost": "$SELENIUM_HOST",
    "hubPort": $SELENIUM_PORT,
    "nodeStatusCheckTimeout": 5000,
    "nodePolling": 5000,
    "role": "node",
    "unregisterIfStillDownAfter": 60000,
    "downPollingLimit": 2,
    "debug": false,
    "servlets" : [],
    "withoutServlets": [],
    "custom": {"port":$APPIUM_PORT,"bootstrap-port":$BOOTSTRAP_PORT,"chromedriver-port":$CHROMEDRIVER_PORT,"selendroid-port":$SELENDROID_PORT}
  }
}
_EOF
)
echo "$nodeconfig" > $node_config_json
