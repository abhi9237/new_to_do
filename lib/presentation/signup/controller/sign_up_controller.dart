import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_demo_app/presentation/bottom_nav/bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../common/common_method.dart';
import '../../../firebase_service/firebase_service.dart';

class SignUpController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  ImagePicker imagePicker = ImagePicker();

  File? image;

  var firstNameController = TextEditingController().obs;
  var lastNameController = TextEditingController().obs;
  var emailController = TextEditingController().obs;
  var phoneNumberController = TextEditingController().obs;
  var passwordController = TextEditingController().obs;
  var confirmPasswordController = TextEditingController().obs;

  var isLoading = false.obs;

  onTapSignUp(BuildContext context) async {
    if (firstNameController.value.text.trim().isEmpty) {
      CustomToast.showToast('Please enter first name', bgColor: Colors.blue);
    } else if (lastNameController.value.text.trim().toString().isEmpty) {
      CustomToast.showToast('Please enter last name', bgColor: Colors.blue);
    } else if (emailController.value.text.trim().isEmpty) {
      CustomToast.showToast('Please enter email address', bgColor: Colors.blue);
    } else if (!GetUtils.isEmail(emailController.value.text.trim())) {
      CustomToast.showToast('Please enter valid email', bgColor: Colors.blue);
    } else if (phoneNumberController.value.text.trim().isEmpty) {
      CustomToast.showToast('Please enter your phone number',
          bgColor: Colors.blue);
    } else if (passwordController.value.text.trim().isEmpty) {
      CustomToast.showToast('Please enter password', bgColor: Colors.blue);
    } else if (confirmPasswordController.value.text.trim().isEmpty) {
      CustomToast.showToast('Please enter confirm password',
          bgColor: Colors.blue);
    } else if (passwordController.value.text.trim().toString() !=
        confirmPasswordController.value.text.trim().toString()) {
      CustomToast.showToast('confirm password do no match with password',
          bgColor: Colors.blue);
    } else {
      isLoading.value = true;
      auth
          .createUserWithEmailAndPassword(
              email: emailController.value.text.trim().toString(),
              password: passwordController.value.text.trim().toString())
          .then((value) async {
        isLoading.value = false;
        await DatabaseService().storeSignUpUserData(
            phoneNumber: phoneNumberController.value.text.trim().toString(),
            firstName: firstNameController.value.text.trim().toString(),
            lastName: lastNameController.value.text.trim().toString(),
            email: emailController.value.text.trim().toString(),
            uid: value.user?.uid,
            image: await DatabaseService().uploadProfileImageFirebaseStorage(
              fileName: image,
            ));
        Get.to(() => const BottomNavigationScreen());
        await CustomToast.showToast('User Added Successfully',
            bgColor: Colors.blue);
        update();
      }).onError((Exception e, stackTrace) {
        isLoading.value = false;
        CustomToast.showToast(e.toString(), bgColor: Colors.blue);
        update();
      });
      update();
    }
  }

  pickedImage(ImageSource imageSource) async {
    await imagePicker
        .pickImage(
            source: imageSource == ImageSource.gallery
                ? ImageSource.gallery
                : ImageSource.camera)
        .then((value) async {
      if (value != null) {
        image = await compressImage(value);
        update();
      }
    });
  }

  onTapAlreadyAccount() {
    Get.back();
  }
}
