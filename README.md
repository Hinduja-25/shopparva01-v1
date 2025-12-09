# ShopParva

ShopParva is an AI-driven multi-platform shopping ecosystem built with Flutter. It features smart price comparison, a kit builder, and a shopping assistant.

## Features implemented (MVP)
- **Authentication**: Email/Password login (simulated).
- **Home Feed**: Personalized product feed.
- **Smart Deal Finder**: Search and compare prices across marketplaces.
- **Kit Builder**: AI-driven kit generation based on budget and type.
- **Watchlist**: Track product prices.
- **Mock Backend**: Node.js server providing API endpoints.

## Prerequisites
- Flutter SDK (Stable)
- Node.js & npm

## Getting Started

### 1. Setup Backend
The app relies on a mock backend for data.

```bash
cd backend
npm install
npm start
```
Server will run on `http://localhost:3000`.

### 2. Setup Flutter App

```bash
# Get dependencies
flutter pub get

# Generate data classes (Required for Freezed models)
dart run build_runner build --delete-conflicting-outputs

# Run the app
flutter run
```

**Note for Android Emulator**: The app uses `localhost`. If running on Android emulator, you might need to change `apiBaseUrl` in `lib/core/constants.dart` to `http://10.0.2.2:3000/api/v1`.

## Architecture
- **State Management**: Riverpod
- **Routing**: GoRouter
- **Networking**: Dio
- **Models**: Freezed & JsonSerializable

## Future Work
- **AR Try-On**: Integration with `ar_flutter_plugin`.
- **Real Backend**: Connect to real affiliate APIs.
- **Firebase Auth**: Replace mock auth with Firebase.
