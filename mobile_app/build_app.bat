@echo off
echo ============================================================
echo   CUHIBOT ANDROID APP BUILDER
echo ============================================================
echo.

echo Step 1: Syncing Capacitor (copying www files to Android)...
call npx cap sync android
if errorlevel 1 (
    echo.
    echo ❌ ERROR: Capacitor sync failed
    echo    Make sure Node.js and npm are installed
    pause
    exit /b 1
)

echo.
echo ✅ Capacitor sync completed
echo.
echo Step 2: Building APK with Gradle...
cd android
call gradlew assembleDebug
if errorlevel 1 (
    echo.
    echo ❌ ERROR: Gradle build failed
    echo    Try opening in Android Studio to see detailed errors
    cd ..
    pause
    exit /b 1
)
cd ..

echo.
echo ============================================================
echo   ✅ BUILD SUCCESSFUL!
echo ============================================================
echo.
echo APK Location:
echo   android\app\build\outputs\apk\debug\app-debug.apk
echo.
echo Next Steps:
echo   1. Copy APK to your phone
echo   2. Install it (enable "Install from unknown sources")
echo   3. Open app and login with your token
echo.
echo Or install via ADB:
echo   adb install -r android\app\build\outputs\apk\debug\app-debug.apk
echo.
pause
