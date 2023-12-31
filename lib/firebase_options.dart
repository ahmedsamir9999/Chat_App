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
    apiKey: 'AIzaSyAlzoz2Lxh1kHO_TfCOfNrpr6gS9x7sX2o',
    appId: '1:784079162480:web:60adb1b9dcba9b838538b5',
    messagingSenderId: '784079162480',
    projectId: 'messenger-9b324',
    authDomain: 'messenger-9b324.firebaseapp.com',
    storageBucket: 'messenger-9b324.appspot.com',
    measurementId: 'G-5C35M9RHNW',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDZ5XU5OGFGZl3ddgQRGfiud4_UDjkp2F4',
    appId: '1:784079162480:android:d8116e545c8a231f8538b5',
    messagingSenderId: '784079162480',
    projectId: 'messenger-9b324',
    storageBucket: 'messenger-9b324.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA4xXvYsRKQ5uTvT_qwigcU6qEazZ4gp9Q',
    appId: '1:784079162480:ios:3ed826f9103c20628538b5',
    messagingSenderId: '784079162480',
    projectId: 'messenger-9b324',
    storageBucket: 'messenger-9b324.appspot.com',
    iosClientId: '784079162480-f4chtsmokg6355mpa1k58o7753livq6t.apps.googleusercontent.com',
    iosBundleId: 'com.example.chat',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA4xXvYsRKQ5uTvT_qwigcU6qEazZ4gp9Q',
    appId: '1:784079162480:ios:d5b69b2159d698a08538b5',
    messagingSenderId: '784079162480',
    projectId: 'messenger-9b324',
    storageBucket: 'messenger-9b324.appspot.com',
    iosClientId: '784079162480-90map4i9b5v6ccueoj8qp9ggfpsqtnok.apps.googleusercontent.com',
    iosBundleId: 'com.example.chat.RunnerTests',
  );
}
