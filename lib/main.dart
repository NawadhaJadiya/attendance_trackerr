import 'package:attendance_trackerr/Models/input_schedule.dart';
import 'package:attendance_trackerr/Screens/start_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> main() async {
  String? _fcmToken;
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  NotificationSettings settings =
      await FirebaseMessaging.instance.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    print('User granted permission');
    // Get the FCM token
    String? token = await FirebaseMessaging.instance.getToken();
    if (token != null) {
      print('FCM Token: $token');
      _fcmToken = token;
      // Send the token to your backend server
      InputSchedule().getToken(_fcmToken);
    } else {
      print('Failed to get FCM token');
    }
  } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
    print('User granted provisional permission');
  } else {
    print('User declined or has not accepted permission');
  }

  FirebaseMessaging.instance.onTokenRefresh.listen((token) {
    print('Refreshed Token: $token');
    _fcmToken = token; // Update the stored token
    // InputSchedule().storeTokenInFirestore(_fcmToken); // Example
  });

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'attendanceTracker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromARGB(255, 11, 0, 23),
        hoverColor: const Color.fromARGB(255, 180, 221, 240),
      ),
      home: const Scaffold(
        body: Start(),
      ),
    );
  }
}
