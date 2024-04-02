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
    apiKey: 'AIzaSyDxSiwouDs-ezj46HmDfjmGnEZ2TW2UOjo',
    appId: '1:443600802362:web:e7c1b20acd38b0f5ea1b03',
    messagingSenderId: '443600802362',
    projectId: 'bada-1c6f7',
    authDomain: 'bada-1c6f7.firebaseapp.com',
    storageBucket: 'bada-1c6f7.appspot.com',
    measurementId: 'G-ME235TH060',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCFKCLeiYUQ8zx0ocKSR5TCZCmEXHBcWlw',
    appId: '1:443600802362:android:c23ad4740db927c2ea1b03',
    messagingSenderId: '443600802362',
    projectId: 'bada-1c6f7',
    storageBucket: 'bada-1c6f7.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDRpeTFgwSIcGgfKs6htrdqfzjDLHeSBqg',
    appId: '1:443600802362:ios:d566189eafd0ba6bea1b03',
    messagingSenderId: '443600802362',
    projectId: 'bada-1c6f7',
    storageBucket: 'bada-1c6f7.appspot.com',
    iosBundleId: 'com.example.b207personal',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDRpeTFgwSIcGgfKs6htrdqfzjDLHeSBqg',
    appId: '1:443600802362:ios:b5fc13081cfaba92ea1b03',
    messagingSenderId: '443600802362',
    projectId: 'bada-1c6f7',
    storageBucket: 'bada-1c6f7.appspot.com',
    iosBundleId: 'com.example.b207personal.RunnerTests',
  );
}