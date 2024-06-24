import 'package:firebase_demo_app/common/image_constant.dart';
import 'package:firebase_demo_app/presentation/splash_screen/controller/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  var controller = Get.put(SplashController());
  SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: Get.height,
        width: Get.width,
        child: Image.asset(
          ImageConstant.onBoarding,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
