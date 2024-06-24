import 'package:firebase_demo_app/common/get_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../../../common/common_bottom_sheet.dart';
import '../../../common/common_text_form_filled.dart';
import '../controller/profile_controller.dart';

class ProfileScreen extends StatelessWidget {
  final controller = Get.put(ProfileController());
  ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Profile',
          style: GoogleFonts.alice(
              color: Colors.blueAccent,
              fontWeight: FontWeight.bold,
              fontSize: 26),
        ),
      ),
      body: GetBuilder(
        init: ProfileController(),
        builder: (ProfileController controller) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    splashColor: Colors.transparent,
                    onTap: () {
                      showMyBottomSheet(context, onTapCamera: () {
                        Navigator.of(context).pop();
                        controller.pickedImage(ImageSource.camera);
                      }, onTapGallery: () {
                        Navigator.of(context).pop();
                        controller.pickedImage(ImageSource.gallery);
                      });
                    },
                    child: Stack(
                      children: [
                        controller.image == null
                            ? Container(
                                height: 130,
                                width: 130,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(color: Colors.blue),
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            controller.userImg.value),
                                        fit: BoxFit.fill)),
                              )
                            : Container(
                                height: 130,
                                width: 130,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(color: Colors.blue),
                                    image: DecorationImage(
                                        image: FileImage(controller.image!),
                                        fit: BoxFit.fill)),
                              ),
                        const Positioned(
                          bottom: 10,
                          right: 7,
                          child: Icon(
                            Icons.camera_alt,
                            color: Colors.blueAccent,
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  CommonTextFormFilled(
                      controller: controller.firstNameController.value,
                      hintText: 'First Name'),
                  const SizedBox(
                    height: 15,
                  ),
                  CommonTextFormFilled(
                      controller: controller.lastNameController.value,
                      hintText: 'Last Name'),
                  const SizedBox(
                    height: 15,
                  ),
                  CommonTextFormFilled(
                      controller: controller.emailController.value,
                      hintText: 'Email'),
                  const SizedBox(
                    height: 15,
                  ),
                  CommonTextFormFilled(
                      controller: controller.phoneNumberController.value,
                      hintText: 'Phone Number'),
                  SizedBox(
                    height: Get.height * 0.15,
                  ),
                  Obx(
                    () => controller.isLoading.value == true
                        ? const Center(
                            child: CircularProgressIndicator(
                            color: Colors.blueAccent,
                          ))
                        : Align(
                            alignment: Alignment.center,
                            child: InkWell(
                              onTap: () {
                                controller.updateUserProfile();
                              },
                              child: Container(
                                alignment: Alignment.center,
                                height: 50,
                                width: MediaQuery.sizeOf(context).width,
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.blue.withOpacity(0.4),
                                          offset: const Offset(0, 4),
                                          blurRadius: 9)
                                    ],
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.blueAccent),
                                child: Text(
                                  'Save Changes',
                                  style: GoogleFonts.alice(
                                      color: Colors.white, fontSize: 16),
                                ),
                              ),
                            ),
                          ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: InkWell(
                      onTap: () {
                        Get.find<GetStorageData>().logOut();
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 50,
                        width: MediaQuery.sizeOf(context).width,
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.blue.withOpacity(0.4),
                                  offset: const Offset(0, 4),
                                  blurRadius: 9)
                            ],
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.blueAccent),
                        child: Text(
                          'Log Out',
                          style: GoogleFonts.alice(
                              color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
