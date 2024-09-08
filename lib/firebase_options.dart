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
    apiKey: 'AIzaSyBNC6U3uFmMqbtkWsT1XGuCz-2QXnV_bDs',
    appId: '1:497142224655:web:a5d4e43388bd4a73ef507a',
    messagingSenderId: '497142224655',
    projectId: 'flash-cards-132b4',
    authDomain: 'flash-cards-132b4.firebaseapp.com',
    storageBucket: 'flash-cards-132b4.appspot.com',
    measurementId: 'G-T53HK4Y8TF',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBkmHpoMR_P8LQ58AZZx0NNdDQiu_TwYvg',
    appId: '1:497142224655:android:b4aa1df6717e5115ef507a',
    messagingSenderId: '497142224655',
    projectId: 'flash-cards-132b4',
    storageBucket: 'flash-cards-132b4.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCTGWoBZ6hKRkM3RqpOO188Hgdsltl5lLk',
    appId: '1:497142224655:ios:80a3e704bd556013ef507a',
    messagingSenderId: '497142224655',
    projectId: 'flash-cards-132b4',
    storageBucket: 'flash-cards-132b4.appspot.com',
    iosBundleId: 'com.example.flashCardsNew',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCTGWoBZ6hKRkM3RqpOO188Hgdsltl5lLk',
    appId: '1:497142224655:ios:80a3e704bd556013ef507a',
    messagingSenderId: '497142224655',
    projectId: 'flash-cards-132b4',
    storageBucket: 'flash-cards-132b4.appspot.com',
    iosBundleId: 'com.example.flashCardsNew',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBNC6U3uFmMqbtkWsT1XGuCz-2QXnV_bDs',
    appId: '1:497142224655:web:4865b6bc407c2dc1ef507a',
    messagingSenderId: '497142224655',
    projectId: 'flash-cards-132b4',
    authDomain: 'flash-cards-132b4.firebaseapp.com',
    storageBucket: 'flash-cards-132b4.appspot.com',
    measurementId: 'G-FNW0NLPRP6',
  );
}
