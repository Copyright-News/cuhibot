# Rebuild Android App with Login Fix

## Quick Steps

The fix is already in `mobile_app/www/index.html`. You just need to rebuild the APK.

### 1. Navigate to mobile app directory
```bash
cd mobile_app
```

### 2. Sync Capacitor (copies www files to Android project)
```bash
npx cap sync android
```

### 3. Open in Android Studio
```bash
npx cap open android
```

### 4. Build APK in Android Studio
1. Wait for Gradle sync to complete
2. Click **Build** → **Build Bundle(s) / APK(s)** → **Build APK(s)**
3. Wait for build to complete
4. Click **locate** in the notification to find the APK
5. APK will be in: `android/app/build/outputs/apk/debug/app-debug.apk`

### 5. Install on Your Phone
```bash
# Connect phone via USB with USB debugging enabled
adb install -r android/app/build/outputs/apk/debug/app-debug.apk
```

Or just copy the APK to your phone and install manually.

## Alternative: Quick Build Script

Create a file `build_app.bat` in the `mobile_app` folder:

```batch
@echo off
echo Building Cuhibot Android App...
echo.

echo Step 1: Syncing Capacitor...
call npx cap sync android
if errorlevel 1 (
    echo ERROR: Capacitor sync failed
    pause
    exit /b 1
)

echo.
echo Step 2: Building APK...
cd android
call gradlew assembleDebug
if errorlevel 1 (
    echo ERROR: Build failed
    cd ..
    pause
    exit /b 1
)
cd ..

echo.
echo ✅ BUILD SUCCESSFUL!
echo.
echo APK location:
echo android\app\build\outputs\apk\debug\app-debug.apk
echo.
pause
```

Then just run:
```bash
cd mobile_app
build_app.bat
```

## What Changed

The fix in `mobile_app/www/index.html` (line ~1099):

**Before (BROKEN):**
```javascript
if (!/^[A-Za-z0-9_-]{10,}$/.test(token)) 
    return showToast('⚠️ Invalid token format');
```

**After (FIXED):**
```javascript
if (token.length < 10) 
    return showToast('⚠️ Token too short (minimum 10 characters)');
```

This allows session tokens like `cuhi_session_token_xQ3CAxU96bvhQUCE7-3miXal89Bj0wUDjOd8sPloNhQ` to pass validation.

## Testing the New APK

1. Install the new APK
2. Open the app
3. Enter:
   - **Server URL**: `https://www.cuhie.mvp.bd`
   - **Token**: `cuhi_session_token_xQ3CAxU96bvhQUCE7-3miXal89Bj0wUDjOd8sPloNhQ`
4. Click **Verify & Connect**
5. ✅ Should login successfully!

## Troubleshooting

### "npx: command not found"
Install Node.js: https://nodejs.org/

### "Android SDK not found"
Install Android Studio: https://developer.android.com/studio

### "Gradle build failed"
1. Open Android Studio
2. Let it download missing dependencies
3. Try building from Android Studio UI

### "adb: command not found"
Add Android SDK platform-tools to PATH:
- Windows: `C:\Users\YourName\AppData\Local\Android\Sdk\platform-tools`

## Version Info

- **App Version**: 2.3.0
- **Version Code**: 4
- **Capacitor**: 8.3.3
- **Fix Applied**: Token validation regex removed

---

**After rebuilding, the app will work with the new session token system!**
