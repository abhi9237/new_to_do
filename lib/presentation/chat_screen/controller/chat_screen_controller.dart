import 'dart:developer';

import 'package:firebase_demo_app/common/get_storage.dart';
import 'package:firebase_demo_app/firebase_service/firebase_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';

import '../modal/get_messge_modal.dart';

class ChatScreenController extends GetxController {
  Rx<TextEditingController> messageController = TextEditingController().obs;
  RxList<String> myMessageList = <String>[].obs;
  RxList<GetMessagesModal> allMessageList = <GetMessagesModal>[].obs;
  String? recieverId;
  String? userName;
  bool permissioinGranted = false;
  String? chatId = '';
  ChatScreenController({this.recieverId, this.userName});
  Future<bool> requestPermissions() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.camera,
      Permission.microphone,
    ].request();

    // Check if permissions are granted
    if (statuses[Permission.camera] == PermissionStatus.granted &&
        statuses[Permission.microphone] == PermissionStatus.granted) {
      // Permissions granted
      await onUserLogin();
      permissioinGranted = true;
      update();

      return true;
    } else {
      permissioinGranted = false;

      update();
      // showPermissionDeniedDialog();
      // Permissions denied
      return false;
    }
  }

  Future<void> onUserLogin() {
    return ZegoUIKitPrebuiltCallInvitationService().init(
      // appID: AppMessageConstants.appID,
      // appSign: AppMessageConstants.appSign,

      appID: 1838475272 /*input your AppID*/,
      appSign:
          'efca394b0259c48ff6e3bd4d8d2aa41b2949dc03ba9f79d5d3ba58e4966bcba7' /*input your AppSign*/,
      userID: Get.find<GetStorageData>().userId,
      userName: Get.find<GetStorageData>().userName,

      plugins: [
        ZegoUIKitSignalingPlugin(),
      ],
      requireConfig: (ZegoCallInvitationData data) {
        ZegoUIKitPrebuiltCallConfig config = ZegoCallType.videoCall == data.type
            ? ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall()
            : ZegoUIKitPrebuiltCallConfig.oneOnOneVoiceCall();
        //  * Bottom Menu Bar Buttons
        config.bottomMenuBarConfig = ZegoBottomMenuBarConfig(
          hideAutomatically: false,
          hideByClick: false,
          style: ZegoMenuBarStyle.dark,
        );
        config.audioVideoViewConfig.useVideoViewAspectFill = true;
        config.audioVideoViewConfig.showUserNameOnView = false;
        // config.audioVideoContainerBuilder;
        // config.audioVideoViewConfig = ZegoPrebuiltAudioVideoViewConfig(
        //   showUserNameOnView: false,
        //   // ignore: avoid_redundant_argument_values
        //   useVideoViewAspectFill: false,
        // );

        // * SHOWING USERNAME ON TOP
        config.foreground = Positioned(
          top: 30,
          left: 0,
          right: 0,
          child: SafeArea(
            child: Center(
              child: Text(
                (data.inviter!.name.toLowerCase() ==
                        userName.toString().toLowerCase())
                    ? data.invitees[0].name
                    : data.inviter!.name,
                // style: AppTextStyle.textStyle600Inter18whiteColor,
              ),
            ),
          ),
        );
        return config;
      },

      // * EVNETS TRIGGERED ON VARIOUS SITUATIONS
      events: ZegoUIKitPrebuiltCallInvitationEvents(
        onInvitationUserStateChanged:
            (List<ZegoSignalingPluginInvitationUserInfo> _) {
          ///  Add your custom logic here.
          ///
          ///
          ///
        },
        onIncomingCallDeclineButtonPressed: () {
          ///  Add your custom logic here.
        },
        onIncomingCallAcceptButtonPressed: () {
          ///  Add your custom logic here.
        },
        onIncomingCallReceived: (
          String callID,
          ZegoCallUser caller,
          ZegoCallType callType,
          List<ZegoCallUser> callees,
          String customData,
        ) {
          ///  Add your custom logic here.
        },
        onIncomingCallCanceled: (String callID, ZegoCallUser caller) {
          ///  Add your custom logic here.
        },
        onIncomingCallTimeout: (String callID, ZegoCallUser caller) {
          ///  Add your custom logic here.
        },
        onOutgoingCallCancelButtonPressed: () {
          ///  Add your custom logic here.
        },
        onOutgoingCallAccepted: (String callID, ZegoCallUser callee) {
          ///  Add your custom logic here.
          // CustomToast.showToast('Call accepted.');
        },
        onOutgoingCallRejectedCauseBusy: (String callID, ZegoCallUser callee) {
          ///  Add your custom logic here.
          // CustomToast.showToast('User is busy on another call!');
        },
        onOutgoingCallDeclined: (String callID, ZegoCallUser callee) {
          ///  Add your custom logic here.
          // CustomToast.showToast('Call rejected.');
        },
        onOutgoingCallTimeout: (String callID, List<ZegoCallUser> callees, _) {
          //  Add your custom logic here.
          // CustomToast.showToast('Call not answered!');
        },
      ),
    );
  }
  // Future<void> onUserLogin() async {
  //   ZegoUIKitPrebuiltCallInvitationService().init(
  //       appID: 1838475272 /*input your AppID*/,
  //       appSign:
  //           'efca394b0259c48ff6e3bd4d8d2aa41b2949dc03ba9f79d5d3ba58e4966bcba7' /*input your AppSign*/,
  //       userID: Get.find<GetStorageData>().userId,
  //       userName: 'Abhis',
  //       plugins: [ZegoUIKitSignalingPlugin()],
  //       requireConfig: (ZegoCallInvitationData data) {
  //         ZegoUIKitPrebuiltCallConfig config =
  //             ZegoCallType.videoCall == data.type
  //                 ? ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall()
  //                 : ZegoUIKitPrebuiltCallConfig.oneOnOneVoiceCall();
  //         //  * Bottom Menu Bar Buttons
  //         config.bottomMenuBarConfig = ZegoBottomMenuBarConfig(
  //           hideAutomatically: false,
  //           hideByClick: false,
  //           style: ZegoMenuBarStyle.dark,
  //         );
  //         config.audioVideoViewConfig.useVideoViewAspectFill = true;
  //         config.audioVideoViewConfig.showUserNameOnView = false;
  //         return config;
  //       });
  // }

  String getConversationID(String userID, String peerID) {
    return userID.hashCode <= peerID.hashCode
        ? '${userID}_$peerID'
        : '${peerID}_$userID';
  }

  onTapSendMessage({String? recieverId, String? name}) {
    if (messageController.value.text.trim().isNotEmpty) {
      DatabaseService().sendMessageFirebase(
        reciverId: recieverId,
        sendAt: DateTime.now(),
        name: name,
        message: messageController.value.text.toString(),
        chatId: getConversationID(
            Get.find<GetStorageData>().userId, recieverId ?? ''),
        // allMessageList.isNotEmpty && allMessageList[0].chatId != ''
        //     ? '${allMessageList[0].chatId}'
        //     : '${Get.find<GetStorageData>().userId}$recieverId',
      );
      GetMessagesModal sendMessageModal = GetMessagesModal(
          name: name,
          text: messageController.value.text.toString(),
          reciverId: recieverId,
          chatId: chatId);
      allMessageList.insert(0, sendMessageModal);
      myMessageList.add(messageController.value.text.trim().toString());
      messageController.value.clear();
    }
    update();
  }

  getAllChatMessages() async {
    allMessageList.value = await DatabaseService().getChatMessages(
        chatId: getConversationID(
            Get.find<GetStorageData>().userId, recieverId ?? ''));
    // '$recieverId${Get.find<GetStorageData>().userId}');
    log(allMessageList.value.length.toString());
    update();
  }

  @override
  void onInit() {
    super.onInit();
    requestPermissions();
    getAllChatMessages();
  }
}
