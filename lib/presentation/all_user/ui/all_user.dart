import 'package:firebase_demo_app/presentation/all_user/controller/all_user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../common/image_constant.dart';

class AllUserScreen extends StatelessWidget {
  var controller = Get.put(AllUserController());
  AllUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'All Users',
          style: GoogleFonts.alice(
              color: Colors.blueAccent,
              fontWeight: FontWeight.bold,
              fontSize: 26),
        ),
      ),
      body: SizedBox(
        height: Get.height,
        width: Get.width,
        child: Visibility(
          visible: controller.allUserList.isNotEmpty,
          child: ListView.builder(
              itemCount: controller.allUserList.length,
              padding: const EdgeInsets.symmetric(horizontal: 15),
              itemBuilder: (context, index) {
                return InkWell(
                  splashColor: Colors.transparent,
                  onTap: () {
                    controller.onTapNavigate(index: index);
                  },
                  child: Container(
                    padding: const EdgeInsets.only(
                        left: 8, right: 8, top: 10, bottom: 10),
                    margin: const EdgeInsets.only(top: 8),
                    // height: 100,
                    width: Get.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        color: Colors.blueAccent.withOpacity(0.1)),
                    child: Row(
                      children: [
                        controller.allUserList[index].image != null &&
                                controller.allUserList[index].image!.isNotEmpty
                            ? Container(
                                height: 70,
                                width: 70,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        image: NetworkImage(controller
                                                .allUserList[index].image ??
                                            ''),
                                        fit: BoxFit.cover)),
                              )
                            : Container(
                                height: 70,
                                width: 70,
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        image: AssetImage(
                                            ImageConstant.noImageFound),
                                        fit: BoxFit.cover)),
                              ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${controller.allUserList[index].firstName} ${controller.allUserList[index].lastName}',
                              style: GoogleFonts.alice(
                                  color: Colors.blueAccent,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14),
                            ),
                            Text(
                              '${controller.allUserList[index].email}',
                              style: GoogleFonts.alice(
                                  color: Colors.blueAccent,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              }),
        ),
      ),
    );
  }
}
