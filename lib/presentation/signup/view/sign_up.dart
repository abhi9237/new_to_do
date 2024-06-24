import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../../../common/common_bottom_sheet.dart';
import '../../../common/common_text_form_filled.dart';
import '../../../common/image_constant.dart';
import '../controller/sign_up_controller.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Create Account',
          style: GoogleFonts.alice(
              color: Colors.blueAccent,
              fontWeight: FontWeight.bold,
              fontSize: 26),
        ),
        centerTitle: true,
      ),
      body: GetBuilder(
        init: SignUpController(),
        builder: (SignUpController controller) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 15,
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
                                    image: const DecorationImage(
                                        image: AssetImage(
                                            ImageConstant.dummyUserImage),
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
                    height: 20,
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
                    height: 10,
                  ),
                  CommonTextFormFilled(
                      controller: controller.emailController.value,
                      hintText: 'Email'),
                  const SizedBox(
                    height: 10,
                  ),
                  CommonTextFormFilled(
                      controller: controller.phoneNumberController.value,
                      hintText: 'Phone number'),
                  const SizedBox(
                    height: 10,
                  ),
                  CommonTextFormFilled(
                      controller: controller.passwordController.value,
                      hintText: 'Password'),
                  const SizedBox(
                    height: 10,
                  ),
                  CommonTextFormFilled(
                      controller: controller.confirmPasswordController.value,
                      hintText: 'Confirm Password'),
                  const SizedBox(
                    height: 30,
                  ),
                  controller.isLoading.value == true
                      ? const CircularProgressIndicator(
                          color: Colors.blueAccent,
                        )
                      : Align(
                          alignment: Alignment.center,
                          child: InkWell(
                            onTap: () {
                              controller.onTapSignUp(context);
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
                                'Sign Up',
                                style: GoogleFonts.alice(
                                    color: Colors.white, fontSize: 16),
                              ),
                            ),
                          ),
                        ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Already have an account',
                    style: GoogleFonts.alice(color: Colors.black, fontSize: 16),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    splashColor: Colors.transparent,
                    onTap: controller.onTapAlreadyAccount,
                    child: SizedBox(
                      height: 40,
                      width: 100,
                      child: Center(
                        child: Text(
                          'Login',
                          style: GoogleFonts.alice(
                              color: Colors.blue, fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                  // Text(
                  //   'Or continue with',
                  //   style:
                  //       GoogleFonts.alice(color: Colors.blueAccent, fontSize: 16),
                  // ),
                  // const SizedBox(
                  //   height: 10,
                  // ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     Container(
                  //       padding: EdgeInsets.all(8),
                  //       decoration: BoxDecoration(
                  //           borderRadius: BorderRadius.circular(10),
                  //           color: Colors.grey),
                  //       child: Icon(Icons.g_mobiledata),
                  //     ),
                  //     SizedBox(
                  //       width: 10,
                  //     ),
                  //     Container(
                  //       padding: EdgeInsets.all(8),
                  //       decoration: BoxDecoration(
                  //           borderRadius: BorderRadius.circular(10),
                  //           color: Colors.grey),
                  //       child: Icon(Icons.g_mobiledata),
                  //     ),
                  //     SizedBox(
                  //       width: 10,
                  //     ),
                  //     Container(
                  //       padding: EdgeInsets.all(8),
                  //       decoration: BoxDecoration(
                  //           borderRadius: BorderRadius.circular(10),
                  //           color: Colors.grey),
                  //       child: Icon(Icons.g_mobiledata),
                  //     )
                  //   ],
                  // )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
