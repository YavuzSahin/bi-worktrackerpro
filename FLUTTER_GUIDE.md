# Complete Flutter Guide for Beginners

## What is Flutter?

Flutter is Google's toolkit for building beautiful, natively compiled applications for mobile, web, and desktop from a single codebase. Think of it as a way to write one app that works perfectly on both Android and iPhone.

### Why Flutter for Work Tracking?
- **Native Performance**: Runs as fast as apps written specifically for each platform
- **Better GPS**: More accurate location tracking than web browsers
- **Works Offline**: Can store data locally when internet is unavailable
- **Professional Feel**: Looks and feels like a "real" mobile app
- **App Store Ready**: Can be published to Google Play and Apple App Store

## Getting Started with Flutter

### Step 1: Install Flutter

#### On Windows:
1. Download Flutter from https://flutter.dev/docs/get-started/install/windows
2. Extract the zip file to `C:\flutter`
3. Add `C:\flutter\bin` to your PATH environment variable
4. Run `flutter doctor` in Command Prompt to check installation

#### On Mac:
1. Download Flutter from https://flutter.dev/docs/get-started/install/macos
2. Extract and move to `/Users/[username]/flutter`
3. Add to PATH in your `.bashrc` or `.zshrc`:
   ```bash
   export PATH="$PATH:/Users/[username]/flutter/bin"
   ```
4. Run `flutter doctor` in Terminal

#### On Linux:
1. Download Flutter from https://flutter.dev/docs/get-started/install/linux
2. Extract to `/home/[username]/flutter`
3. Add to PATH in `.bashrc`:
   ```bash
   export PATH="$PATH:/home/[username]/flutter/bin"
   ```
4. Run `flutter doctor`

### Step 2: Install Android Studio
1. Download from https://developer.android.com/studio
2. Install with default settings
3. Open Android Studio → Configure → SDK Manager
4. Install Android SDK and create a virtual device (emulator)

### Step 3: Verify Installation
Run this command to check everything is working:
```bash
flutter doctor
```
You should see green checkmarks for:
- Flutter SDK
- Android toolchain
- Android Studio

## Understanding Your Work Tracking App

### Project Structure
```
flutter_app/
├── lib/                        # Your app code lives here
│   ├── main.dart              # App starts here
│   ├── core/                  # Core functionality
│   │   ├── models/            # Data structures (User, WorkLog)
│   │   ├── services/          # API calls, GPS, storage
│   │   ├── l10n/              # Translations
│   │   └── theme/             # Colors and styling
│   └── features/              # App features
│       ├── auth/              # Login screen
│       └── work_tracking/     # Main work dashboard
├── android/                   # Android-specific settings
├── ios/                       # iOS-specific settings (if building for iPhone)
└── pubspec.yaml              # App configuration and dependencies
```

### Key Files Explained

#### `pubspec.yaml` - App Configuration
This is like a recipe that tells Flutter what ingredients (packages) your app needs:
```yaml
dependencies:
  flutter_bloc: ^8.1.3      # State management
  geolocator: ^10.1.0       # GPS location
  http: ^1.1.0              # API calls
```

#### `lib/main.dart` - App Entry Point
This is where your app starts. It sets up the basic structure and navigation.

#### `lib/core/services/api_service.dart` - Backend Communication
This handles talking to your web server:
- Login requests
- Check-in/check-out
- Getting work history

#### `lib/features/auth/presentation/pages/login_page.dart` - Login Screen
The screen where users enter their username and password.

#### `lib/features/work_tracking/presentation/pages/mobile_dashboard_page.dart` - Main Screen
The main screen where employees can:
- See if they're currently working
- Start work (check-in)
- End work (check-out)
- View work history

## Running Your App

### Step 1: Setup
1. Open terminal/command prompt
2. Navigate to your flutter_app folder:
   ```bash
   cd flutter_app
   ```

### Step 2: Install Dependencies
```bash
flutter pub get
```
This downloads all the packages your app needs.

### Step 3: Generate Required Code
```bash
flutter packages pub run build_runner build
```
This creates some code files automatically.

### Step 4: Connect Your Backend
Edit `lib/core/services/api_service.dart` and change this line:
```dart
static const String baseUrl = 'http://your-server-url.com';
```
To your actual server URL (like the web app URL).

### Step 5: Run the App

#### On Android Emulator:
1. Start Android Studio
2. Open AVD Manager (Android Virtual Device)
3. Start an emulator
4. Run: `flutter run`

#### On Physical Android Device:
1. Enable Developer Options on your phone:
   - Go to Settings → About Phone
   - Tap "Build Number" 7 times
2. Enable USB Debugging in Developer Options
3. Connect phone to computer with USB cable
4. Run: `flutter run`

#### On iPhone (Mac only):
1. Open `ios/Runner.xcworkspace` in Xcode
2. Select your device or simulator
3. Click the play button in Xcode

## Understanding the App Features

### Login System
- Uses the same accounts as your web app
- Demo accounts: admin/admin123 and ahmed/123456
- Stores login token securely on the device

### GPS Tracking
- Asks for location permission when first used
- Captures exact GPS coordinates when checking in/out
- More accurate than web browser location

### Work Dashboard
Shows:
- Current work status (working/not working)
- Buttons to start/end work
- Today's work hours
- Recent activity history

### Multilingual Support
- Currently supports English and Turkish
- Easy to add more languages by editing files in `lib/core/l10n/`

## Common Commands

### Development Commands
```bash
# Install dependencies
flutter pub get

# Run the app in debug mode
flutter run

# Run with hot reload (updates instantly)
flutter run --hot

# Check for issues
flutter doctor

# See connected devices
flutter devices

# Build for release (Android)
flutter build apk

# Clean build files
flutter clean
```

### Debugging Commands
```bash
# Run with verbose output
flutter run -v

# See app logs
flutter logs

# Analyze code for issues
flutter analyze
```

## Building for Release

### Android APK (for Google Play Store or direct install)
```bash
flutter build apk --release
```
The APK file will be created in `build/app/outputs/flutter-apk/`

### Android App Bundle (recommended for Play Store)
```bash
flutter build appbundle --release
```

### iOS (Mac only, for App Store)
```bash
flutter build ios --release
```

## Customizing Your App

### Changing App Name
Edit `android/app/src/main/AndroidManifest.xml`:
```xml
<application android:label="Your App Name">
```

### Changing App Icon
1. Replace files in `android/app/src/main/res/mipmap-*/ic_launcher.png`
2. Or use the `flutter_launcher_icons` package for easier icon generation

### Adding New Languages
1. Create new `.arb` file in `lib/core/l10n/` (like `app_es.arb` for Spanish)
2. Add translations following the English file format
3. Update supported locales in `main.dart`

### Changing Colors/Theme
Edit `lib/core/theme/app_theme.dart`:
```dart
static const Color primaryColor = Color(0xFF3B82F6); // Blue
// Change to your preferred color
```

## Troubleshooting

### Common Issues

**"flutter: command not found"**
- Flutter is not in your PATH
- Re-run the installation steps

**"No devices found"**
- Start Android emulator or connect physical device
- Run `flutter devices` to check

**"Gradle build failed"**
- Clean the project: `flutter clean`
- Delete `android/.gradle` folder
- Run `flutter pub get` again

**"Location permissions denied"**
- Check device settings
- Ensure app has location permission
- On Android: Settings → Apps → Your App → Permissions

**"API connection failed"**
- Check the server URL in `api_service.dart`
- Ensure your backend server is running
- Check device internet connection

### Getting Help
1. Run `flutter doctor` to check your setup
2. Check Flutter documentation: https://flutter.dev/docs
3. Search Stack Overflow for specific error messages
4. Check the app logs with `flutter logs`

## Next Steps

1. **Install Flutter** following the steps above
2. **Run `flutter doctor`** to verify installation
3. **Navigate to the flutter_app folder** and run `flutter pub get`
4. **Update the API URL** in the code to point to your server
5. **Run `flutter run`** to start the app
6. **Test login** with the demo accounts

Your Flutter app will give users a much better mobile experience than the web app, with native performance, better GPS tracking, and the ability to work offline!

Need help with any specific step? Just let me know what you're trying to do and any error messages you see.