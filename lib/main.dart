import 'package:chat_box/view/LogIn.dart';
import 'package:chat_box/view/home_screen.dart';
import 'package:chat_box/view/intro_screen.dart';
import 'package:chat_box/view/setting_screen.dart';
import 'package:chat_box/view/signUp.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'firebase_options.dart';
import 'firebase_sarvice/firebase_notification.dart';
import 'firebase_sarvice/firebase_notificton/FirebaseMessagingServices.dart';
import 'firebase_sarvice/firebase_notificton/NotificationServices.dart';
import 'firebase_sarvice/google_services.dart';




@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  if (kDebugMode) {
    print("Handling a background message: ${message.notification!.title}");
  }
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // Get.to(const UserPage());
}
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  NotificationServices.notificationServices.initNotification();
  FirebaseNotificationSarvices.firebaseNotificationSarvices.requestPermission();
  await FirebaseNotificationSarvices.firebaseNotificationSarvices.generateDeviceToken();
  FirebaseMessagingServices.firebaseMessagingServices.onMessageListener();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(

      theme: ThemeData.dark(),

      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',

      // home: SettingScreen(),
      home: GoogleSignInServices.googleSignInServices.currentUser() == null
          ? const SignupScreen()
          : const HomeScreen(),
      // getPages: [
        // GetPage(name: '/', page: ()=>IntroScreen()),
        // GetPage(
        //     name: '/',
        //     page: () =>
        //         GoogleSignInServices.googleSignInServices.currentUser() == null
        //             ? LoginScreen()
        //             : HomeScreen()),
        // GetPage(name: '/', page: () => SignupScreen()),

      // home: SignupScreen() ,


    );
  }
}
