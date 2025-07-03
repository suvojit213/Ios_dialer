# Phone Dialer App

A beautiful iOS-style phone dialer app built with Flutter for Android 15.

## Features

- **iOS-style Design**: Clean, modern interface inspired by iOS Phone app
- **Keypad Dialer**: Full numeric keypad with haptic feedback
- **Call History**: View recent, missed, and all calls
- **Contacts**: Browse and search contacts with quick actions
- **Favorites**: Quick access to favorite contacts
- **Responsive Design**: Optimized for Android 15 devices

## Screenshots

The app includes four main screens:
- **Favorites**: Quick dial contacts and favorite list
- **Recents**: Call history with filtering options
- **Contacts**: Full contact list with search functionality
- **Keypad**: Numeric dialer with call functionality

## Technical Details

- **Framework**: Flutter 3.x
- **Target Platform**: Android 15 (API level 34)
- **Minimum SDK**: Android 5.0 (API level 21)
- **Design Language**: iOS Cupertino widgets
- **Permissions**: Phone, Contacts, Call Log access

## Installation

1. Ensure Flutter SDK is installed and configured
2. Clone or extract the project
3. Run `flutter pub get` to install dependencies
4. Connect an Android device or start an emulator
5. Run `flutter run` to build and install the app

## Permissions

The app requires the following permissions:
- `CALL_PHONE`: Make phone calls
- `READ_PHONE_STATE`: Access phone state
- `READ_CONTACTS`: Read device contacts
- `WRITE_CONTACTS`: Modify contacts
- `READ_CALL_LOG`: Access call history
- `WRITE_CALL_LOG`: Modify call logs
- `SEND_SMS`: Send text messages
- `VIBRATE`: Haptic feedback

## Dependencies

- `cupertino_icons`: iOS-style icons
- `url_launcher`: Launch phone calls and SMS
- `permission_handler`: Handle runtime permissions
- `contacts_service`: Access device contacts

## Build Instructions

### Debug Build
```bash
flutter build apk --debug
```

### Release Build
```bash
flutter build apk --release
```

### Bundle for Play Store
```bash
flutter build appbundle --release
```

## Project Structure

```
lib/
├── main.dart                 # App entry point
├── models/                   # Data models
│   ├── contact.dart
│   └── call_log.dart
├── services/                 # Business logic
│   ├── phone_service.dart
│   ├── contact_service.dart
│   └── call_log_service.dart
└── screens/                  # UI screens
    ├── dialer_screen.dart
    ├── recents_screen.dart
    ├── contacts_screen.dart
    └── favorites_screen.dart
```

## Customization

The app uses iOS design principles with:
- Cupertino widgets for native iOS feel
- System colors and typography
- Smooth animations and transitions
- Haptic feedback for interactions

## Developer

**Developed by Suvojeet**

## License

This project is created for demonstration purposes. Please ensure you have proper permissions and comply with platform guidelines when using phone and contact functionalities.

## Notes

- This is a demo app with mock data for contacts and call logs
- Real device testing recommended for full functionality
- Ensure proper permissions are granted on the device
- Compatible with Android 6.0+ (API level 23+) for runtime permissions

