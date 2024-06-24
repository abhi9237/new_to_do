import 'package:firebase_demo_app/common/get_storage.dart';
import 'package:firebase_demo_app/presentation/login/view/login_page.dart';
import 'package:get/get.dart';

import '../../bottom_nav/bottom_navigation.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(seconds: 2)).then((value) {
      if (Get.find<GetStorageData>().token != '') {
        Get.offAll(() => const BottomNavigationScreen());
      } else {
        Get.to(() => LoginScreen());
      }
    });
  }
}
