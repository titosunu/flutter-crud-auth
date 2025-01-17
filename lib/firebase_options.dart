// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
    apiKey: 'AIzaSyBEx9jNBwh3NwygIIto4pXK7RLSrqdu0Oo',
    appId: '1:117037535268:web:34396d8e99eed10c1588b1',
    messagingSenderId: '117037535268',
    projectId: 'siega-db-77d1d',
    authDomain: 'siega-db-77d1d.firebaseapp.com',
    storageBucket: 'siega-db-77d1d.appspot.com',
    measurementId: 'G-JBPHYW5472',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAGOQBEi-FBcRd2lxX28kDwbys1Rd1AUew',
    appId: '1:117037535268:android:b8ab662ffaded0f31588b1',
    messagingSenderId: '117037535268',
    projectId: 'siega-db-77d1d',
    storageBucket: 'siega-db-77d1d.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAQa7Nw8yAlwqsSgvL8yBe6UVMeFfJKq2E',
    appId: '1:117037535268:ios:1060adf67431280c1588b1',
    messagingSenderId: '117037535268',
    projectId: 'siega-db-77d1d',
    storageBucket: 'siega-db-77d1d.appspot.com',
    iosBundleId: 'com.example.siegaapp',
  );

}