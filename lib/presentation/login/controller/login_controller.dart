import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_demo_app/common/get_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/common_method.dart';
import '../../../routes/app_routes.dart';
import '../../forgot_password/ui/forgot_password.dart';
import '../../signup/view/sign_up.dart';

class LoginController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;

  var emailController = TextEditingController().obs;
  var passwordController = TextEditingController().obs;

  var isLoading = false.obs;

  onTapLogin() {
    // Get.offAllNamed(AppRoutes.bottomNavigation);
    if (!GetUtils.isEmail(emailController.value.text.trim())) {
      CustomToast.showToast('Please enter valid email', bgColor: Colors.blue);
    } else if (passwordController.value.text.trim().toString().isEmpty) {
      CustomToast.showToast('Please enter valid password',
          bgColor: Colors.blue);
    } else {
      isLoading.value = true;
      auth
          .signInWithEmailAndPassword(
              email: emailController.value.text.trim().toString(),
              password: passwordController.value.text.trim().toString())
          .then((value) async {
        Get.find<GetStorageData>().setUserId(value.user?.uid ?? '');
        Get.find<GetStorageData>().setUserId(value.user?.displayName ?? '');
        IdTokenResult? idTokenResult =
            await FirebaseAuth.instance.currentUser?.getIdTokenResult();
        log("here is UserTocken ${idTokenResult?.token}");
        Get.find<GetStorageData>().setToken(idTokenResult?.token ?? '');
        log(" tocken======= ${Get.find<GetStorageData>().token.toString()}");
        isLoading.value = false;
        Get.offAllNamed(AppRoutes.bottomNavigation);
        update();
      }).onError((error, stackTrace) {
        isLoading.value = false;
        CustomToast.showToast(error.toString(), bgColor: Colors.blue);
        update();
      });
    }
  }

  onTapCreateAccount() {
    Get.to(() => const SignUpScreen());
  }

  onTapForgotPassword() {
    Get.to(() => ForgotPasswordScreen());
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    // if (Get.find<GetStorageData>().token != '') {
    //   Get.offAllNamed(AppRoutes.bottomNavigation);
    // }
  }
}
