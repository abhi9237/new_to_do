import 'dart:developer';

import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_demo_app/common/get_storage.dart';
import 'package:firebase_demo_app/routes/app_routes.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';

import 'firebase_service/notifications.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey();
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

initNotification() {
  NotificationServices notification = NotificationServices();
  notification.requestNotificationPermission();
  notification.firebaseInit();
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
      options: const FirebaseOptions(
    apiKey: 'AIzaSyDZD_6WXwRWGn1AoHNQhNEReLYoEn04BC0',
    appId: '1:865851331213:android:b0327cde61498705b588c4',
    messagingSenderId: '865851331213',
    projectId: 'fir-todoapp-ef68f',
    storageBucket: 'fir-todoapp-ef68f.appspot.com',
  ));
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  initNotification();

  await GetStorage.init();
  var userSession = Get.put(GetStorageData());
  userSession.init();

  await NotificationServices()
      .getDeviceToken()
      .then((value) => userSession.setDeviceToken(value));

  log('userSession.deviceToken${userSession.deviceToken}');

  await FirebaseAppCheck.instance.activate(
    androidProvider: AndroidProvider.debug, // Or AndroidProvider.safetyNet
    appleProvider: AppleProvider.deviceCheck, // Or AppleProvider .appAttest
  );
  ZegoUIKitPrebuiltCallInvitationService().setNavigatorKey(navigatorKey);
  ZegoUIKit().initLog().then((value) {
    ZegoUIKitPrebuiltCallInvitationService().useSystemCallingUI(
      [ZegoUIKitSignalingPlugin()],
    );
    runApp(MyApp(
      navigatorKey: navigatorKey,
    ));
  });
}

class MyApp extends StatefulWidget {
  final GlobalKey<NavigatorState> navigatorKey;

  const MyApp({super.key, required this.navigatorKey});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // home: InstaReelScreen(),
      navigatorKey: widget.navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      initialRoute: AppRoutes.demoScreen,
      getPages: AppRoutes.pagesList,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}
