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
        return macos;
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
    apiKey: 'AIzaSyBkXcYpAe263DMHf3bhpttzwOepW9Rhk1g',
    appId: '1:517611188866:web:6874e67c842def8f64ba9b',
    messagingSenderId: '517611188866',
    projectId: 'tp2flutter-28cff',
    authDomain: 'tp2flutter-28cff.firebaseapp.com',
    storageBucket: 'tp2flutter-28cff.appspot.com',
    measurementId: 'G-F1S96RFS4E',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDANmwZ5M1ma6bQpTvVg2ny4x8i5LOIYKs',
    appId: '1:517611188866:android:78ca71107c74025064ba9b',
    messagingSenderId: '517611188866',
    projectId: 'tp2flutter-28cff',
    storageBucket: 'tp2flutter-28cff.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCnTdCEpJ-N9DIHMi2xIJcgX2wvP6e4Rc4',
    appId: '1:517611188866:ios:bbd864cf651d292f64ba9b',
    messagingSenderId: '517611188866',
    projectId: 'tp2flutter-28cff',
    storageBucket: 'tp2flutter-28cff.appspot.com',
    iosBundleId: 'com.example.flutterApplication1',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCnTdCEpJ-N9DIHMi2xIJcgX2wvP6e4Rc4',
    appId: '1:517611188866:ios:934747f464b90c4464ba9b',
    messagingSenderId: '517611188866',
    projectId: 'tp2flutter-28cff',
    storageBucket: 'tp2flutter-28cff.appspot.com',
    iosBundleId: 'com.example.flutterApplication1.RunnerTests',
  );
}
