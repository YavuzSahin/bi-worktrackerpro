# WorkTracker Pro - Flutter Mobile App

A native Flutter mobile application for remote work tracking with GPS logging and multilingual support.

## Features

### 🏢 Employee Features
- **GPS-based Check-in/Check-out**: Automatic location capture when starting or ending work
- **Real-time Work Tracking**: Live status display and work duration tracking
- **Work History**: View daily, weekly, and monthly work logs
- **Multilingual Support**: Available in English, Turkish, Spanish, Portuguese, and Arabic
- **Offline Capability**: Local storage with sync when online
- **Native Performance**: Optimized for mobile devices

### 🔐 Authentication & Security
- **JWT-based Authentication**: Secure token-based login system
- **Role-based Access**: Employee and admin role separation
- **Biometric Authentication**: Fingerprint/Face ID support (optional)
- **Secure Storage**: Encrypted local data storage

### 📱 Mobile-First Design
- **Material Design 3**: Modern, intuitive interface
- **Dark/Light Theme**: Automatic theme switching
- **Responsive Layout**: Optimized for all screen sizes
- **Native Animations**: Smooth, performant transitions
- **Accessibility**: Full accessibility support

## Technical Architecture

### 🏗️ Architecture Pattern
- **BLoC Pattern**: State management with flutter_bloc
- **Clean Architecture**: Separation of concerns with feature-based structure
- **Repository Pattern**: Abstracted data layer
- **Dependency Injection**: Service locator pattern

### 📦 Key Dependencies
- `flutter_bloc`: State management
- `geolocator`: GPS location services
- `permission_handler`: Device permissions
- `shared_preferences`: Local storage
- `http`: API communication
- `flutter_map`: Interactive maps
- `json_annotation`: JSON serialization

### 🗂️ Project Structure
```
lib/
├── core/                   # Core functionality
│   ├── l10n/              # Internationalization
│   ├── models/            # Data models
│   ├── services/          # Core services
│   ├── theme/             # App theming
│   └── widgets/           # Reusable widgets
├── features/              # Feature modules
│   ├── auth/              # Authentication
│   └── work_tracking/     # Work tracking
└── main.dart              # App entry point
```

## Getting Started

### Prerequisites
- Flutter SDK (3.10.0+)
- Dart SDK (3.0.0+)
- Android Studio / VS Code
- Android device/emulator or iOS device/simulator

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd flutter_app
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Generate code**
   ```bash
   flutter packages pub run build_runner build
   ```

4. **Configure API endpoint**
   Update the `baseUrl` in `lib/core/services/api_service.dart`:
   ```dart
   static const String baseUrl = 'https://your-server-url.com';
   ```

5. **Run the app**
   ```bash
   flutter run
   ```

### Build for Release

**Android APK:**
```bash
flutter build apk --release
```

**Android App Bundle:**
```bash
flutter build appbundle --release
```

**iOS:**
```bash
flutter build ios --release
```

## Configuration

### Android Permissions
The app requires the following permissions (already configured in AndroidManifest.xml):
- `ACCESS_FINE_LOCATION`: For precise GPS tracking
- `ACCESS_COARSE_LOCATION`: For approximate location
- `ACCESS_BACKGROUND_LOCATION`: For background location updates
- `INTERNET`: For API communication

### iOS Permissions
Add the following to `ios/Runner/Info.plist`:
```xml
<key>NSLocationWhenInUseUsageDescription</key>
<string>This app needs location access to track work locations.</string>
<key>NSLocationAlwaysAndWhenInUseUsageDescription</key>
<string>This app needs location access to track work locations.</string>
```

## API Integration

The app connects to the same backend API as the web version:

### Authentication Endpoints
- `POST /api/login` - User login
- `POST /api/logout` - User logout

### Work Tracking Endpoints
- `GET /api/status` - Get current work status
- `POST /api/checkin` - Check in to work
- `POST /api/checkout` - Check out from work
- `GET /api/logs` - Get work logs

### Demo Accounts
- **Admin**: username `admin`, password `admin123`
- **Employee**: username `ahmed`, password `123456`

## Features Comparison: Web vs Flutter

| Feature | Web App | Flutter App |
|---------|---------|-------------|
| GPS Tracking | ✅ Browser API | ✅ Native GPS |
| Offline Support | ❌ Limited | ✅ Full Support |
| Push Notifications | ❌ | ✅ Native |
| Background Tracking | ❌ | ✅ Available |
| App Store Distribution | ❌ | ✅ Yes |
| Cross-platform | ✅ Universal | ✅ iOS + Android |
| Installation | ❌ Not Required | ✅ App Install |
| Performance | ✅ Good | ✅ Excellent |
| Native Features | ❌ Limited | ✅ Full Access |

## Deployment

### Android Play Store
1. Configure app signing in `android/app/build.gradle`
2. Build release bundle: `flutter build appbundle --release`
3. Upload to Google Play Console

### iOS App Store
1. Configure signing in Xcode
2. Build for release: `flutter build ios --release`
3. Archive and upload via Xcode or App Store Connect

## Development Roadmap

### Phase 1 - Core Features ✅
- Authentication system
- GPS-based check-in/check-out
- Work status tracking
- Basic multilingual support

### Phase 2 - Enhanced Features 🚧
- Background location tracking
- Push notifications
- Offline data sync
- Advanced reporting

### Phase 3 - Advanced Features 📋
- Biometric authentication
- Geofencing
- Time tracking analytics
- Team management (admin features)

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests if applicable
5. Submit a pull request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Support

For support and questions:
- Create an issue in the repository
- Contact the development team
- Check the documentation

---

**WorkTracker Pro Flutter** - Native mobile work tracking made simple.