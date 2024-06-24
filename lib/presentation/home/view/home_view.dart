import 'package:firebase_demo_app/common/get_storage.dart';
import 'package:firebase_demo_app/common/image_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../common/custom_animation.dart';
import '../controller/home_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          ' My Todo',
          style: GoogleFonts.alice(
              color: Colors.blueAccent,
              fontWeight: FontWeight.bold,
              fontSize: 26),
        ),
      ),
      body: GetBuilder(
        init: HomeController(),
        builder: (HomeController controller) {
          return controller.isLoading.value == true
              ? const Center(
                  child: CircularProgressIndicator(
                  color: Colors.blueAccent,
                ))
              : Visibility(
                  visible: controller.toDoList.isNotEmpty,
                  child: RefreshIndicator(
                    onRefresh: () {
                      return controller.fetchData();
                    },
                    child: ListView.builder(
                        // physics: const BouncingScrollPhysics(),
                        itemCount: controller.toDoList.length,
                        padding:
                            const EdgeInsets.only(left: 15, right: 15, top: 10),
                        itemBuilder: (context, i) {
                          return CustomAnimatedItem(
                            index: i,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 8),
                              margin: const EdgeInsets.only(bottom: 10),
                              width: Get.width,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.blueAccent.withOpacity(0.2)),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  controller.toDoList[i].images != null &&
                                          controller
                                              .toDoList[i].images!.isNotEmpty
                                      ? Container(
                                          height: 80,
                                          width: 90,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              image: DecorationImage(
                                                  image: NetworkImage(controller
                                                      .toDoList[i].images![0]),
                                                  fit: BoxFit.cover)),
                                        )
                                      : Container(
                                          height: 80,
                                          width: 90,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              image: const DecorationImage(
                                                  image: AssetImage(
                                                      ImageConstant
                                                          .noImageFound),
                                                  fit: BoxFit.cover)),
                                        ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              controller.toDoList[i].title
                                                      .toString()
                                                      .capitalizeFirst ??
                                                  '',
                                              style: GoogleFonts.alice(
                                                  color: Colors.blueAccent,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          controller.toDoList[i].description
                                                  .toString()
                                                  .capitalizeFirst ??
                                              '',
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.alice(
                                              color: Colors.blueAccent,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Spacer(),
                                  PopupMenuButton<String>(
                                    padding: const EdgeInsets.all(0),
                                    itemBuilder: (BuildContext context) {
                                      return <PopupMenuEntry<String>>[
                                        PopupMenuItem<String>(
                                          value: 'option1',
                                          child: ListTile(
                                            leading: const Icon(
                                              Icons.edit,
                                              color: Colors.blueAccent,
                                            ),
                                            title: Text('Edit',
                                                style: GoogleFonts.alice(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14)),
                                          ),
                                        ),
                                        PopupMenuItem<String>(
                                          value: 'option2',
                                          child: ListTile(
                                            leading: const Icon(
                                              Icons.delete,
                                              color: Colors.blueAccent,
                                            ),
                                            title: Text('Delete',
                                                style: GoogleFonts.alice(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14)),
                                          ),
                                        ),
                                      ];
                                    },
                                    onSelected: (String value) {
                                      // Handle the selected option
                                      switch (value) {
                                        case 'option1':
                                          controller.editTodo(
                                              getToDoData:
                                                  controller.toDoList[i]);
                                          break;
                                        case 'option2':
                                          controller.onTapDelete(
                                              uid: Get.find<GetStorageData>()
                                                  .userId,
                                              title:
                                                  controller.toDoList[i].title,
                                              index: i);
                                          break;
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
                );
        },
      ),
    );
  }
}
