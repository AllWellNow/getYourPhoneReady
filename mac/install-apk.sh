#!/bin/bash

APK_PATH="/Users/awn/Desktop/app-chat.apk"
LOG_FILE="install_log.txt"

# Essential packages to keep
ESSENTIAL_PACKAGES=(
    "com.android.settings"
    "com.android.systemui"
    "com.google.android.gms"
    "com.android.phone"
    "com.android.server.telecom"
    "com.android.providers.settings"
    "com.android.externalstorage"
    "com.android.shell"
    "com.android.soundpicker"  
)

# Remove non-essential packages
remove_non_essential_apps() {
    echo "Removing non-essential packages..." | tee -a "$LOG_FILE"
    INSTALLED_PACKAGES=$(adb shell pm list packages | sed 's/package://')

    for PACKAGE in $INSTALLED_PACKAGES; do
        if [[ ! " ${ESSENTIAL_PACKAGES[@]} " =~ " ${PACKAGE} " ]]; then
            echo "Removing package: $PACKAGE" | tee -a "$LOG_FILE"
            adb shell su -c "pm uninstall --user 0 $PACKAGE" | tee -a "$LOG_FILE"
            check_system_health
        else
            echo "Keeping essential package: $PACKAGE" | tee -a "$LOG_FILE"
        fi
    done
    echo "Package removal completed." | tee -a "$LOG_FILE"
}

# Install APK
install_apk() {
    echo "Installing APK..." | tee -a "$LOG_FILE"
    adb push "$APK_PATH" /data/local/tmp/app.apk | tee -a "$LOG_FILE"
    adb shell pm install /data/local/tmp/app.apk | tee -a "$LOG_FILE"
}

# Main execution
echo "Starting script..." | tee -a "$LOG_FILE"
adb wait-for-device
remove_non_essential_apps
install_apk
adb reboot
echo "Script completed successfully!" | tee -a "$LOG_FILE"