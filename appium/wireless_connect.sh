#!/bin/bash

echo "connect device "
# if [ ! -z "$ANDROID_DEVICE" ]; then
#     connected_devices=$(adb devices)
#     IFS=',' read -r -a array <<< "$ANDROID_DEVICE"
#     for i in "${!array[@]}"
#     do
#         array_device=$(echo ${array[$i]} | tr -d " ")
#         #string contains check
#         if [[ ${connected_devices} != *${array_device}* ]]; then
#             echo "Connecting to: ${array_device}"
#             adb connect ${array_device}
#             echo "Success!"
#         fi
#     done
#     #Give time to finish connection
#     sleep 1
# fi
