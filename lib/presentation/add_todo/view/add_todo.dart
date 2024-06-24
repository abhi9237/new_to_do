import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../common/common_text_form_filled.dart';
import '../../home/modal/home_modal.dart';
import '../controller/add_todo_controller.dart';

class AddTodoScreen extends StatelessWidget {
  GetToDoModal? getToDoModal;
  String? callFrom;

  AddTodoScreen({super.key, this.callFrom = '', this.getToDoModal});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          callFrom == 'edit' ? 'Edit Todo' : 'Add Todo',
          style: GoogleFonts.alice(
              color: Colors.blueAccent,
              fontWeight: FontWeight.bold,
              fontSize: 26),
        ),
      ),
      body: GetBuilder(
        init: AddTodoController(editToDoData: getToDoModal, callFrom: callFrom),
        builder: (AddTodoController controller) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  CommonTextFormFilled(
                    controller: controller.titleController.value,
                    hintText: 'Title',
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CommonTextFormFilled(
                    contentPadding: const EdgeInsets.only(
                        top: 10, left: 10, right: 10, bottom: 10),
                    hintText: 'Description',
                    controller: controller.descriptionController.value,
                    minLines: 6,
                    maxLines: null,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  InkWell(
                    onTap: () {
                      controller.pickImagesList();
                    },
                    child: Container(
                      height: 120,
                      width: Get.width * 0.4,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.blueAccent.withOpacity(0.1)),
                      child: const Icon(
                        Icons.add,
                        size: 40,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Obx(
                    () => Visibility(
                      visible: controller.images.value.isNotEmpty,
                      child: SizedBox(
                        height: 120,
                        child: ListView.builder(
                            itemCount: controller.images.value.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return Stack(
                                children: [
                                  Container(
                                      margin: const EdgeInsets.only(right: 10),
                                      height: 120,
                                      width: Get.width * 0.4,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.blueAccent
                                              .withOpacity(0.1),
                                          image: controller.images.every(
                                                  (element) => element.path
                                                      .contains('https'))
                                              ? DecorationImage(
                                                  image: NetworkImage(controller
                                                      .images
                                                      .value[index]
                                                      .path),
                                                  fit: BoxFit.cover,
                                                )
                                              : DecorationImage(
                                                  image: FileImage(
                                                    File(controller.images
                                                        .value[index].path),
                                                  ),
                                                  fit: BoxFit.cover,
                                                ))),
                                  Positioned(
                                      top: -10,
                                      right: 0,
                                      child: IconButton(
                                          onPressed: () {
                                            controller.images.removeAt(index);
                                          },
                                          icon: const Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                          )))
                                ],
                              );
                            }),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Obx(() => controller.isLoading.value == true
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: Colors.blueAccent,
                          ),
                        )
                      : Align(
                          alignment: Alignment.center,
                          child: InkWell(
                            onTap: () {
                              callFrom == 'edit'
                                  ? controller.onTapEdit(context)
                                  : controller.onTapAddTodo();
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
                                callFrom == 'edit' ? 'Edit' : 'Add',
                                style: GoogleFonts.alice(
                                    color: Colors.white, fontSize: 16),
                              ),
                            ),
                          ),
                        )),
                  const SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
