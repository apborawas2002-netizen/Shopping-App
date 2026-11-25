import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

/// Firebase config for project shopping-app-1da90.
/// Android also reads android/app/google-services.json.
///
/// To use the local emulators instead, run with:
/// `--dart-define=USE_FIREBASE_EMULATOR=true`
class FirebaseConfig {
  static const bool useEmulator = bool.fromEnvironment(
    'USE_FIREBASE_EMULATOR',
  );

  static const String projectId = 'shopping-app-1da90';
  static const String messagingSenderId = '349300952474';
  static const String storageBucket = 'shopping-app-1da90.firebasestorage.app';

  static const String webApiKey = 'AIzaSyCLDyKwXZoqZY_FVikP8O1WxB9NxjKW4xw';
  static const String webAppId = '1:349300952474:web:0f9a5a11476863ddc0be23';
  static const String authDomain = 'shopping-app-1da90.firebaseapp.com';
  static const String measurementId = 'G-GC8YQ8VWWM';

  static const String androidApiKey = 'AIzaSyA3XJeiZz-z3p6-M3DPZnSor46UZkGFGOo';
  static const String androidAppId = '1:349300952474:android:edb84f6be541e9d3c0be23';

  static bool get isConfigured {
    return !_isPlaceholder(projectId) &&
        !_isPlaceholder(messagingSenderId) &&
        !_isPlaceholder(webApiKey) &&
        !_isPlaceholder(webAppId) &&
        !_isPlaceholder(androidApiKey) &&
        !_isPlaceholder(androidAppId);
  }

  static bool _isPlaceholder(String value) =>
      value.isEmpty || value.startsWith('YOUR_');
}

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (FirebaseConfig.useEmulator) {
      if (kIsWeb) return emulatorWeb;
      if (defaultTargetPlatform == TargetPlatform.android) {
        return emulatorAndroid;
      }
    } else {
      if (kIsWeb) return web;
      if (defaultTargetPlatform == TargetPlatform.android) return android;
    }
    throw UnsupportedError('Field & Co. runs on Android and the web.');
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: FirebaseConfig.webApiKey,
    appId: FirebaseConfig.webAppId,
    messagingSenderId: FirebaseConfig.messagingSenderId,
    projectId: FirebaseConfig.projectId,
    authDomain: FirebaseConfig.authDomain,
    storageBucket: FirebaseConfig.storageBucket,
    measurementId: FirebaseConfig.measurementId,
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: FirebaseConfig.androidApiKey,
    appId: FirebaseConfig.androidAppId,
    messagingSenderId: FirebaseConfig.messagingSenderId,
    projectId: FirebaseConfig.projectId,
    storageBucket: FirebaseConfig.storageBucket,
  );

  static const FirebaseOptions emulatorWeb = FirebaseOptions(
    apiKey: 'demo-api-key',
    appId: '1:1234567890:web:demo',
    messagingSenderId: '1234567890',
    projectId: 'demo-field-co',
    authDomain: 'localhost',
  );

  static const FirebaseOptions emulatorAndroid = FirebaseOptions(
    apiKey: 'demo-api-key',
    appId: '1:1234567890:android:demo',
    messagingSenderId: '1234567890',
    projectId: 'demo-field-co',
  );
}

String firebaseEmulatorHost() {
  if (kIsWeb) return 'localhost';
  if (defaultTargetPlatform == TargetPlatform.android) return '10.0.2.2';
  return 'localhost';
}
