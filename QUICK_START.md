# Quick Start Guide - Work Tracker Flutter App

## I'm Completely New to Flutter - What Do I Do?

### Option 1: Use Online Flutter (Easiest)
1. Go to https://zapp.run/new
2. Upload your `flutter_app` folder
3. Click "Run" to test the app in browser
4. No installation needed!

### Option 2: Install Flutter on Your Computer (Recommended)

#### Windows Users:
```bash
# 1. Download Flutter
# Go to: https://flutter.dev/docs/get-started/install/windows
# Download the zip file and extract to C:\flutter

# 2. Add to PATH (search "Environment Variables" in Windows)
# Add: C:\flutter\bin

# 3. Check installation
flutter doctor
```

#### Mac Users:
```bash
# 1. Install Flutter
curl -L https://storage.googleapis.com/flutter_infra_release/releases/stable/macos/flutter_macos_3.16.0-stable.zip -o flutter.zip
unzip flutter.zip
sudo mv flutter /usr/local/

# 2. Add to PATH
echo 'export PATH="$PATH:/usr/local/flutter/bin"' >> ~/.zshrc
source ~/.zshrc

# 3. Check installation
flutter doctor
```

## After Installing Flutter

### 1. Setup Your App
```bash
# Navigate to the app folder
cd flutter_app

# Download dependencies
flutter pub get

# Generate required code files
flutter packages pub run build_runner build
```

### 2. Connect to Your Backend Server
Edit `lib/core/services/api_service.dart`:

**Find this line:**
```dart
static const String baseUrl = 'http://your-server-url.com';
```

**Change it to your server URL:**
```dart
static const String baseUrl = 'https://your-replit-app.replit.app';
```
*Replace with your actual Replit app URL*

### 3. Run the App

#### On Android Phone:
```bash
# Enable Developer Mode on your phone:
# Settings → About Phone → Tap "Build Number" 7 times
# Settings → Developer Options → Enable "USB Debugging"
# Connect phone to computer with USB cable

flutter run
```

#### On Computer (Emulator):
```bash
# Install Android Studio first
# Open Android Studio → Configure → AVD Manager
# Create and start a virtual device

flutter run
```

### 4. Test the App
Use these accounts to test:
- **Employee**: username `ahmed`, password `123456`
- **Admin**: username `admin`, password `admin123`

## What You'll See

### Login Screen
- Language selector (English/Turkish)
- Username and password fields
- Demo credentials displayed

### Employee Dashboard
- Work status card (working/not working)
- Start Work / End Work buttons
- Today's hours, this week, this month stats
- Recent activity list

### Features That Work
- ✅ Login with existing accounts
- ✅ GPS location capture
- ✅ Check-in/Check-out tracking
- ✅ Work history display
- ✅ Multilingual support
- ✅ Dark/light theme

## Common First-Time Issues

### "flutter: command not found"
**Solution**: Flutter not installed properly
```bash
# Re-download Flutter and add to PATH
# Windows: Add C:\flutter\bin to PATH
# Mac/Linux: Add to ~/.bashrc or ~/.zshrc
```

### "No devices found"
**Solution**: No Android device connected
```bash
# Check connected devices
flutter devices

# Options:
# 1. Connect Android phone with USB debugging
# 2. Start Android emulator
# 3. Use web version: flutter run -d chrome
```

### "Build failed" or "Gradle error"
**Solution**: Clean and rebuild
```bash
flutter clean
flutter pub get
flutter run
```

### "API connection error"
**Solution**: Wrong server URL
1. Check your Replit web app URL
2. Update `baseUrl` in `api_service.dart`
3. Make sure your server is running

### "Location permission denied"
**Solution**: Enable location on your device
- Android: Settings → Apps → Work Tracker → Permissions → Location → Allow
- Make sure GPS is enabled on your phone

## Building for Release

### Create APK for Android:
```bash
flutter build apk --release
```
APK file will be in: `build/app/outputs/flutter-apk/app-release.apk`

### Install on Phone:
1. Transfer APK to your phone
2. Enable "Install from Unknown Sources" in phone settings
3. Tap the APK file to install

## What Makes This Better Than the Web App?

| Feature | Web App | Flutter App |
|---------|---------|-------------|
| Speed | Good | ⚡ Much Faster |
| GPS Accuracy | Basic | 🎯 Precise |
| Works Offline | No | ✅ Yes |
| Push Notifications | Limited | 📱 Native |
| App Store | No | 🏪 Can Publish |
| Feels Like | Website | 📱 Real App |

## Need Help?

### Check Your Setup:
```bash
flutter doctor -v
```

### See Available Devices:
```bash
flutter devices
```

### View App Logs:
```bash
flutter logs
```

### Most Common Solution:
```bash
# When in doubt, clean everything:
flutter clean
flutter pub get
flutter packages pub run build_runner build
flutter run
```

## Next Steps After Success

1. **Customize the app** - Change colors, logos, app name
2. **Add more languages** - Spanish, Portuguese, Arabic
3. **Add features** - Push notifications, offline sync
4. **Publish to stores** - Google Play Store, Apple App Store

Your Flutter app will give your employees a much better mobile experience than the web version!

**Still confused?** Just run these 4 commands one by one:
```bash
cd flutter_app
flutter pub get
flutter packages pub run build_runner build
flutter run
```

If you see errors, copy the error message and I'll help you fix it!