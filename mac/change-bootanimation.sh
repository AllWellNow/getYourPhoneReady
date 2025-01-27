#!/bin/bash

# Path to your custom bootanimation.zip
BOOT_ANIMATION_PATH="/../bootanimation.zip"

# Function to replace boot animation
replace_boot_animation() {
    echo "Replacing boot animation..."
    adb shell su -c "mount -o remount,rw /system"
    adb push "$BOOT_ANIMATION_PATH" /system/media/bootanimation.zip
    adb shell su -c "chmod 644 /system/media/bootanimation.zip"
    adb shell su -c "mount -o remount,ro /system"
    echo "Boot animation replaced successfully."
}

# Wait for device to connect
echo "Waiting for device..."
adb wait-for-device

# Check if a device is connected
DEVICE=$(adb devices | grep -w "device")
if [ -z "$DEVICE" ]; then
    echo "No device connected. Please connect your phone and try again."
    exit 1
else
    echo "Device connected: $(adb devices | awk 'NR==2 {print $1}')"

    # Ensure the device is rooted
    ROOT_CHECK=$(adb shell su -c "id" 2>&1)
    if [[ "$ROOT_CHECK" == *"uid=0(root)"* ]]; then
        echo "Root access confirmed. Replacing boot animation."
        replace_boot_animation
    else
        echo "Device is not rooted. This script requires root access."
        exit 1
    fi
fi