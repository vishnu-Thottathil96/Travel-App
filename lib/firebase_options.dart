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
    apiKey: 'AIzaSyDoNV5XRo-XVblUrV9GSzJT9m_HsDQBMio',
    appId: '1:879444360046:web:57a1a0b296247c5fd79f7f',
    messagingSenderId: '879444360046',
    projectId: 'unlockkerala',
    authDomain: 'unlockkerala.firebaseapp.com',
    storageBucket: 'unlockkerala.appspot.com',
    measurementId: 'G-BWDJP7R6PN',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAdE-L_rmVawM2psS1l2d7rIvzDxnpHqgE',
    appId: '1:879444360046:android:386193f1833a6ef0d79f7f',
    messagingSenderId: '879444360046',
    projectId: 'unlockkerala',
    storageBucket: 'unlockkerala.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDDc3mQsNUTMkGd-wLAZ6OxJXJBpT45aDM',
    appId: '1:879444360046:ios:c1b4cdd4d90a6b88d79f7f',
    messagingSenderId: '879444360046',
    projectId: 'unlockkerala',
    storageBucket: 'unlockkerala.appspot.com',
    iosClientId: '879444360046-3f5itdk85umo89h82d2v1ucnh2l80mpe.apps.googleusercontent.com',
    iosBundleId: 'com.example.unloack',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDDc3mQsNUTMkGd-wLAZ6OxJXJBpT45aDM',
    appId: '1:879444360046:ios:c1b4cdd4d90a6b88d79f7f',
    messagingSenderId: '879444360046',
    projectId: 'unlockkerala',
    storageBucket: 'unlockkerala.appspot.com',
    iosClientId: '879444360046-3f5itdk85umo89h82d2v1ucnh2l80mpe.apps.googleusercontent.com',
    iosBundleId: 'com.example.unloack',
  );
}