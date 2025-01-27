@echo off

echo Disabling front camera...
adb shell su -c "mount -o remount,rw /system"
adb shell su -c "mv /dev/camera_front /dev/camera_front_disabled"
adb shell su -c "chmod 000 /dev/camera_front_disabled"
adb shell su -c "mount -o remount,ro /system"
echo Front camera disabled successfully.
pause