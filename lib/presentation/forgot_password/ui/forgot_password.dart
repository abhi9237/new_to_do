import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../common/common_text_form_filled.dart';
import '../controller/forgot_password_controller.dart';

class ForgotPasswordScreen extends StatelessWidget {
  var controller = Get.put(ForgotPasswordController());
  ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Forgot Password',
          style: GoogleFonts.alice(
              color: Colors.blueAccent,
              fontWeight: FontWeight.bold,
              fontSize: 26),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              Text(
                "Welcome back you've been missed !",
                textAlign: TextAlign.center,
                style: GoogleFonts.alice(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 22),
              ),
              const SizedBox(
                height: 50,
              ),
              CommonTextFormFilled(
                  controller: controller.emailController.value,
                  hintText: 'Email'),
              const SizedBox(
                height: 30,
              ),
              Obx(
                () => controller.isLoading.value == true
                    ? const CircularProgressIndicator(
                        color: Colors.blueAccent,
                      )
                    : Align(
                        alignment: Alignment.center,
                        child: InkWell(
                          onTap: controller.onTapForgotPassword,
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
                              'Forgot Password',
                              style: GoogleFonts.alice(
                                  color: Colors.white, fontSize: 16),
                            ),
                          ),
                        ),
                      ),
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
