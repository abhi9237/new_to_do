import 'package:firebase_demo_app/common/image_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../common/common_text_form_filled.dart';
import '../controller/login_controller.dart';

class LoginScreen extends StatelessWidget {
  var controller = Get.put(LoginController());
  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Login',
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
                height: 15,
              ),
              CommonTextFormFilled(
                  controller: controller.passwordController.value,
                  hintText: 'Password'),
              const SizedBox(
                height: 15,
              ),
              InkWell(
                splashColor: Colors.transparent,
                onTap: controller.onTapForgotPassword,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: SizedBox(
                    height: 30,
                    child: Text(
                      'Forgot your password?',
                      style: GoogleFonts.alice(
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: 14),
                    ),
                  ),
                ),
              ),
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
                          onTap: controller.onTapLogin,
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
                              'Sign In',
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
              InkWell(
                onTap: controller.onTapCreateAccount,
                child: SizedBox(
                  height: 40,
                  child: Text(
                    'Create new account',
                    style: GoogleFonts.alice(color: Colors.black, fontSize: 16),
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Text(
                'Or continue with',
                style:
                    GoogleFonts.alice(color: Colors.blueAccent, fontSize: 16),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 40,
                    width: 50,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.grey.withOpacity(0.3)),
                    child: Image.asset(
                      AppIcons.google,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                    height: 40,
                    width: 50,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.grey.withOpacity(0.3)),
                    child: Image.asset(
                      AppIcons.facebook,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                    height: 40,
                    width: 50,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.grey.withOpacity(0.3)),
                    child: Image.asset(
                      AppIcons.apple,
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
