@echo off

:: Path to your custom bootanimation.zip
set BOOT_ANIMATION_PATH=C:\..\bootanimation.zip

:: Init
echo Waiting for device...
adb wait-for-device

:: Check if a device is connected
adb devices | find "device" >nul
if %ERRORLEVEL% NEQ 0 (
    echo No device connected. Please connect your phone and try again.
    exit /b 1
)

:: Check if the device is rooted
echo Checking root access...
adb shell su -c "id" | find "uid=0(root)" >nul
if %ERRORLEVEL% NEQ 0 (
    echo Device is not rooted. This script requires root access.
    exit /b 1
)

:: Replace boot animation
echo Replacing boot animation...
adb shell su -c "mount -o remount,rw /system"
adb push "%BOOT_ANIMATION_PATH%" /system/media/bootanimation.zip
adb shell su -c "chmod 644 /system/media/bootanimation.zip"
adb shell su -c "mount -o remount,ro /system"
echo Boot animation replaced successfully.