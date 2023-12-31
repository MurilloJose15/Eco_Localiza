// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyB18uI7S4bCAzLRMJMc8Hd-0Im-xE9_UZ0',
    appId: '1:141212125059:web:9615478eaa4b1c136098b6',
    messagingSenderId: '141212125059',
    projectId: 'ecolocaliza-94a24',
    authDomain: 'ecolocaliza-94a24.firebaseapp.com',
    storageBucket: 'ecolocaliza-94a24.appspot.com',
    measurementId: 'G-B1Z9D6WPV8',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCodLcaBuEpde6DiX37Jr8UZbN6OngEGOY',
    appId: '1:141212125059:android:715a8114dd8ac7296098b6',
    messagingSenderId: '141212125059',
    projectId: 'ecolocaliza-94a24',
    storageBucket: 'ecolocaliza-94a24.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDHW8-f3RaHJR9qPz9MptCapdcJ18odLhI',
    appId: '1:141212125059:ios:ef990ad90e2cca946098b6',
    messagingSenderId: '141212125059',
    projectId: 'ecolocaliza-94a24',
    storageBucket: 'ecolocaliza-94a24.appspot.com',
    iosBundleId: 'com.example.ecoLocaliza',
  );
}
