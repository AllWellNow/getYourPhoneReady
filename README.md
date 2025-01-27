# getYourPhoneReady

## Program Overview
This program configures a Google Pixel phone to:
- Remove all apps.
- Install a single APK.
- Disable the front camera while keeping the rear camera functional.
- Customize the boot animation and boot logo.

---

## Requirements
- A **rooted Google Pixel phone**.
- A **Windows PC**.
- A **USB cable**.
- **ADB and Fastboot tools** installed on the Windows machine.
- The following files (included in this repository):
  1. `install-apk.bat`
  2. `change-bootanimation.bat`
  3. `disable-front-camera.bat`

---

## Step-by-Step Instructions

### 1. Prepare Your Phone
1. Unlock your phone and enable Developer Options:
   - Go to **Settings** > **About phone** > Tap **Build number** 7 times.
   - In **Settings**, enable **USB Debugging** in Developer Options.
2. Connect your phone to your PC using a USB cable.

---

### 2. Remove All Apps and Install the APK
1. On your Windows PC, run the `install-apk.bat` script.
2. The script will:
   - Remove all apps except essential system apps.
   - Install the provided APK - specify the path to the APK by modifying APK_PATH variable.
   - Device will be rebooted after.

---

### 3. Disable the Front Camera
1. Run the `disable-front-camera.bat` script.
2. This script will:
   - Disable the front camera by renaming its driver file.
   - Ensure only the back camera remains operational.
3. Reboot the device if prompted.

---

### 4. Change the Boot Animation
#### Replace the Boot Animation:
1. Place your custom `bootanimation.zip` file in the same directory as `change-bootanimation.bat`.
2. Run the `change-bootanimation.bat` script.

#### Replace the Boot Logo:
1. The custom boot logo (`logo.img`) is included in this repository.
2. Change directory (terminal command 'cd') to this folder on your PC and run the following commands:
   ```batch
   adb push logo.img /sdcard/
   adb shell su -c "dd if=/sdcard/logo.img of=/dev/block/bootdevice/by-name/logo"
   adb reboot
