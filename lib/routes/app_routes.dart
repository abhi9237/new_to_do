import 'package:firebase_demo_app/presentation/splash_screen/splash_screen.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

import '../presentation/bottom_nav/bottom_navigation.dart';
import '../presentation/login/view/login_page.dart';
import '../presentation/signup/view/sign_up.dart';

class AppRoutes {
  static const String demoScreen = "/demo";
  static const String login = "/login";
  static const String signUp = "/signUp";
  static const String bottomNavigation = "/bottmNavigaton";
  static const String clipper = "/clipper";

  static List<GetPage> pagesList = [
    GetPage(name: login, page: () => LoginScreen()),
    GetPage(name: demoScreen, page: () => SplashScreen()),
    GetPage(name: signUp, page: () => const SignUpScreen()),
    GetPage(name: bottomNavigation, page: () => const BottomNavigationScreen()),
  ];
}
