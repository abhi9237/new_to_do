import 'dart:developer';
import 'dart:io';

import 'package:firebase_demo_app/common/get_storage.dart';
import 'package:firebase_demo_app/firebase_service/firebase_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../common/common_method.dart';

class ProfileController extends GetxController {
  var firstNameController = TextEditingController().obs;
  var lastNameController = TextEditingController().obs;
  var emailController = TextEditingController().obs;
  var phoneNumberController = TextEditingController().obs;

  ImagePicker imagePicker = ImagePicker();
  File? image;

  RxString userImg = ''.obs;

  var isLoading = false.obs;

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

  fetUserDetails() async {
    var d = await DatabaseService()
        .fetchUserDetails(uid: Get.find<GetStorageData>().userId);
    firstNameController.value.text = d.firstName ?? '';
    lastNameController.value.text = d.lastName ?? '';
    emailController.value.text = d.email ?? '';
    phoneNumberController.value.text = d.phoneNumber ?? '';
    userImg.value = d.image ?? '';
  }

  updateUserProfile() async {
    isLoading.value = true;
    image ??= File(userImg.value);
    log(Get.find<GetStorageData>().userId.toString());

    await DatabaseService()
        .updateUserProfileData(
            phoneNumber: phoneNumberController.value.text.trim(),
            email: emailController.value.text.trim(),
            image: await DatabaseService()
                .uploadProfileImageFirebaseStorage(fileName: image),
            lastName: lastNameController.value.text.trim(),
            firstName: firstNameController.value.text.trim(),
            uid: Get.find<GetStorageData>().userId)
        .then((value) => isLoading.value = false);

    update();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetUserDetails();
  }
}
