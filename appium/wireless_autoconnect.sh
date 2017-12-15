#!/bin/bash

if [ ! -z "$REMOTE_ADB" ]; then

    if [ -z "$REMOTE_ADB_POLLING_SEC" ]; then
        REMOTE_ADB_POLLING_SEC=5
    fi

    function connect() {
        while true
        do
            #to avoid immediate run
            sleep ${REMOTE_ADB_POLLING_SEC}
            # /root/wireless_connect.sh
            if [ -z "$ANDROID_DEVICE" ]; then
              echo "Connecting to: ${ANDROID_DEVICE}"
              adb connect ${ANDROID_DEVICE}
              echo "Success!"
            fi
        done
    }

    ( trap "true" HUP ; connect ) >/dev/null 2>/dev/null </dev/null & disown
fi
