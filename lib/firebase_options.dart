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
        return macos;
      case TargetPlatform.windows:
        return windows;
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
    apiKey: 'AIzaSyDMQBwN8t3rjQRdfl1P6zyq0q8uXHG9DeA',
    appId: '1:724621599065:web:8a708007acec9358d3ec48',
    messagingSenderId: '724621599065',
    projectId: 'chatbox-48c70',
    authDomain: 'chatbox-48c70.firebaseapp.com',
    storageBucket: 'chatbox-48c70.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDqGIqqSRiFf-3VvMHvXdH_BjEPNFSCycI',
    appId: '1:724621599065:android:a80108db44394406d3ec48',
    messagingSenderId: '724621599065',
    projectId: 'chatbox-48c70',
    storageBucket: 'chatbox-48c70.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAczfQj-KnSIOaSsdh4PepUNQJdtYLMaXE',
    appId: '1:724621599065:ios:8ce1ab60cc0e7094d3ec48',
    messagingSenderId: '724621599065',
    projectId: 'chatbox-48c70',
    storageBucket: 'chatbox-48c70.appspot.com',
    iosBundleId: 'com.example.chatBox',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAczfQj-KnSIOaSsdh4PepUNQJdtYLMaXE',
    appId: '1:724621599065:ios:8ce1ab60cc0e7094d3ec48',
    messagingSenderId: '724621599065',
    projectId: 'chatbox-48c70',
    storageBucket: 'chatbox-48c70.appspot.com',
    iosBundleId: 'com.example.chatBox',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDMQBwN8t3rjQRdfl1P6zyq0q8uXHG9DeA',
    appId: '1:724621599065:web:33c0c38eadbd0947d3ec48',
    messagingSenderId: '724621599065',
    projectId: 'chatbox-48c70',
    authDomain: 'chatbox-48c70.firebaseapp.com',
    storageBucket: 'chatbox-48c70.appspot.com',
  );
}
