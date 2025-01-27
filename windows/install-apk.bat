@echo off
setlocal enabledelayedexpansion

:: Configuration
set APK_PATH=C:\Users\awn\Desktop\app-chat.apk
set LOG_FILE=install_log.txt

:: Essential packages to keep
set ESSENTIAL_PACKAGES=com.android.settings 
com.android.systemui 
com.google.android.gms 
com.android.phone 
com.android.server.telecom 
com.android.providers.settings 
com.android.externalstorage 
com.android.shell

:: Logging function
echo. > "%LOG_FILE%"

:: Remove non-essential packages
echo Removing non-essential packages... >> "%LOG_FILE%"
for /f "tokens=*" %%P in ('adb shell pm list packages') do (
    set PACKAGE=%%P
    set PACKAGE=!PACKAGE:package=!
    set KEEP=0
    for %%E in (%ESSENTIAL_PACKAGES%) do (
        if "!PACKAGE!"=="%%E" set KEEP=1
    )
    if "!KEEP!"=="0" (
        echo Removing package: !PACKAGE! >> "%LOG_FILE%"
        adb shell su -c "pm uninstall --user 0 !PACKAGE!" >> "%LOG_FILE%"
    ) else (
        echo Keeping essential package: !PACKAGE! >> "%LOG_FILE%"
    )
)
echo Package removal completed. >> "%LOG_FILE%"

:: Install APK
echo Installing APK... >> "%LOG_FILE%"
adb push "%APK_PATH%" /data/local/tmp/app.apk >> "%LOG_FILE%"
adb shell pm install /data/local/tmp/app.apk >> "%LOG_FILE%"

:: Reboot the device
adb reboot
echo Script completed successfully! >> "%LOG_FILE%"
pause