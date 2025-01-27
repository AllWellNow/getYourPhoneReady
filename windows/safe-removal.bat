@echo off

:: Path to your APK file
set APK_PATH="C:\path\to\your\app.apk"

:: Check if the APK file exists
if not exist %APK_PATH% (
    echo Error: APK file not found at %APK_PATH%
    exit /b 1
)

:: Function to uninstall all non-system apps
echo Fetching list of non-system apps...
for /f "tokens=2 delims=:" %%a in ('adb shell pm list packages -3') do (
    set PACKAGE=%%a

    :: Exclude your app's package name if needed
    if not %%a==com.your.app.package (
        echo Removing app: %%a
        adb uninstall %%a
    )
)
echo All non-system apps removed.

:: Install the APK
@REM echo Installing APK...
@REM adb install -r %APK_PATH%
@REM if %ERRORLEVEL% equ 0 (
@REM     echo APK installed successfully!
@REM ) else (
@REM     echo Failed to install APK.
@REM     exit /b 1
@REM )