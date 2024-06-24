import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_demo_app/common/get_storage.dart';
import 'package:firebase_demo_app/presentation/chat_screen/controller/chat_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

import '../../../common/common_text_form_filled.dart';
import '../../video/ui/video_screen.dart';
import '../modal/get_messge_modal.dart';

class ChatScreen extends StatelessWidget {
  final String? name;
  final String? recieverId;
  ChatScreen({super.key, this.name, this.recieverId});
  final controller = Get.put(ChatScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Chat',
          style: GoogleFonts.alice(
              color: Colors.blueAccent,
              fontWeight: FontWeight.bold,
              fontSize: 26),
        ),
        actions: [
          ZegoSendCallInvitationButton(
            onPressed: (_, __, ___) {
              Get.to(() => VideoScreen(
                    userID: recieverId,
                    userName: name,
                    chatId: controller.getConversationID(
                        Get.find<GetStorageData>().userId, recieverId ?? ''),
                  ));
            },
            iconSize: Size(30, 30),
            isVideoCall: true,
            resourceID: "firebase_calling",
            invitees: [
              ZegoUIKitUser(
                id: '$recieverId',
                name: name.toString(),
              ),
            ],
          ),
          InkWell(
            splashColor: Colors.transparent,
            onTap: () {
              Get.to(() => VideoScreen(
                    userID: recieverId,
                    userName: name,
                    chatId: controller.getConversationID(
                        Get.find<GetStorageData>().userId, recieverId ?? ''),
                  ));
            },
            child: const Icon(
              Icons.video_camera_back,
              color: Colors.blueAccent,
              size: 25,
            ),
          ),
          Icon(
            Icons.call,
            color: Colors.blueAccent,
            size: 25,
          ),
          SizedBox(
            width: 10,
          )
        ],
      ),
      body: GetBuilder(
        init: ChatScreenController(recieverId: recieverId, userName: name),
        builder: (ChatScreenController controller) {
          return SizedBox(
            width: Get.width,
            child: Stack(
              children: [
                Column(
                  children: [
                    Expanded(
                      child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                        stream: FirebaseFirestore.instance
                            .collection('chat')
                            .doc(controller.getConversationID(
                                Get.find<GetStorageData>().userId,
                                recieverId ?? ''))
                            .collection('message')
                            .orderBy('sendAt', descending: true)
                            .limit(20)
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.data?.docs != null &&
                              snapshot.data!.docs.isNotEmpty) {
                            controller.allMessageList.clear();
                            for (var i in snapshot.data!.docs) {
                              Map<String, dynamic> d =
                                  i.data() as Map<String, dynamic>;
                              var data = GetMessagesModal.fromJson(d);
                              controller.allMessageList.add(data);
                            }
                          }

                          return ListView.builder(
                              itemCount: controller.allMessageList.length,
                              reverse: true,
                              padding: EdgeInsets.only(
                                  left: 10,
                                  right: 10,
                                  top: 10,
                                  bottom: Get.height * 0.1),
                              itemBuilder: (context, index) {
                                log(controller.allMessageList[index].text
                                    .toString());
                                return controller
                                            .allMessageList[index].reciverId
                                            .toString()
                                            .toLowerCase() !=
                                        Get.find<GetStorageData>()
                                            .userId
                                            .toString()
                                            .toLowerCase()
                                    ? message(
                                        isAlignLeft: false,
                                        message: controller
                                            .allMessageList[index].text)
                                    : message(
                                        isAlignLeft: true,
                                        message: controller
                                            .allMessageList[index].text);
                              });
                        },
                      ),
                    ),
                  ],
                ),
                Positioned(
                    bottom: 0, child: sendMessage(controller, name, recieverId))
              ],
            ),
          );
        },
      ),
    );
  }

  Widget message({bool? isAlignLeft = false, String? message}) {
    return Align(
      alignment:
          isAlignLeft == true ? Alignment.bottomLeft : Alignment.bottomRight,
      child: Container(
        padding: const EdgeInsets.only(left: 12, right: 12, top: 7, bottom: 7),
        margin: EdgeInsets.only(
            bottom: 10,
            left: isAlignLeft == false ? 150 : 0,
            right: isAlignLeft == true ? 150 : 0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey.withOpacity(0.1)),
        child: Text(
          message ?? '',
          style: GoogleFonts.alice(
              color: Colors.black, fontWeight: FontWeight.w500, fontSize: 14),
        ),
      ),
    );
  }

  Widget sendMessage(
      ChatScreenController controller, String? name, String? recieverId) {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10),
      height: 80,
      width: Get.width,
      decoration: const BoxDecoration(color: Colors.white),
      child: Row(
        children: [
          const SizedBox(
            width: 10,
          ),
          SizedBox(
            width: Get.width * 0.75,
            child: CommonTextFormFilled(
              controller: controller.messageController.value,
              maxLines: 1,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          InkWell(
            splashColor: Colors.transparent,
            onTap: () {
              // controller.allMessageList[0].text;
              // log(controller.allMessageList[0].text.toString());
              controller.onTapSendMessage(recieverId: recieverId, name: name);
            },
            child: Container(
              height: 50,
              width: 50,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: Colors.blueAccent),
              child: const Icon(
                Icons.send,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}
