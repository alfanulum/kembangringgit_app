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
    apiKey: 'AIzaSyClg8TPAjnSg7P9axErb5waTRhUPnaUJGw',
    appId: '1:829526457477:web:6c928573c1f133dc6b7dec',
    messagingSenderId: '829526457477',
    projectId: 'kembangringgit-app-2874c',
    authDomain: 'kembangringgit-app-2874c.firebaseapp.com',
    storageBucket: 'kembangringgit-app-2874c.appspot.com',
    measurementId: 'G-V6LLMEH0CP',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAewZ0LN2ne0TXvpiz0f3WjkeGwPSJxqkI',
    appId: '1:829526457477:android:d2b44955ec651f7e6b7dec',
    messagingSenderId: '829526457477',
    projectId: 'kembangringgit-app-2874c',
    storageBucket: 'kembangringgit-app-2874c.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB6Wq7IECEpp-LdMZPqIf0lSxMUa9oK0HM',
    appId: '1:829526457477:ios:1fa23631fa0e16fc6b7dec',
    messagingSenderId: '829526457477',
    projectId: 'kembangringgit-app-2874c',
    storageBucket: 'kembangringgit-app-2874c.appspot.com',
    iosBundleId: 'com.example.kembangringgitApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyB6Wq7IECEpp-LdMZPqIf0lSxMUa9oK0HM',
    appId: '1:829526457477:ios:1fa23631fa0e16fc6b7dec',
    messagingSenderId: '829526457477',
    projectId: 'kembangringgit-app-2874c',
    storageBucket: 'kembangringgit-app-2874c.appspot.com',
    iosBundleId: 'com.example.kembangringgitApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyClg8TPAjnSg7P9axErb5waTRhUPnaUJGw',
    appId: '1:829526457477:web:c736c87ac7cbe46d6b7dec',
    messagingSenderId: '829526457477',
    projectId: 'kembangringgit-app-2874c',
    authDomain: 'kembangringgit-app-2874c.firebaseapp.com',
    storageBucket: 'kembangringgit-app-2874c.appspot.com',
    measurementId: 'G-YYV80YFBYR',
  );
}
