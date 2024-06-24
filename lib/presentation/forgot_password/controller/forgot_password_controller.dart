import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/common_method.dart';

class ForgotPasswordController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  var emailController = TextEditingController().obs;

  var isLoading = false.obs;

  onTapForgotPassword() {
    if (!GetUtils.isEmail(emailController.value.text.trim())) {
      CustomToast.showToast('Please enter valid email', bgColor: Colors.blue);
    } else {
      isLoading.value = true;
      auth
          .sendPasswordResetEmail(email: emailController.value.text.toString())
          .then((value) {
        CustomToast.showToast(
            'We have sent you email to recover password, please check email',
            bgColor: Colors.blue);
        emailController.value.clear();
        isLoading.value = false;
      }).onError((error, stackTrace) {
        isLoading.value = false;
        CustomToast.showToast(error.toString(), bgColor: Colors.blue);
      });
    }
    update();
  }
}
