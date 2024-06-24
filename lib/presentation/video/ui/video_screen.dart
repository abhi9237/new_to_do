import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
// import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class VideoScreen extends StatelessWidget {
  final String? userID;
  final String? chatId;
  final String? userName;

  const VideoScreen({super.key, this.userID, this.userName, this.chatId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ZegoUIKitPrebuiltCall(
        appID:
            1838475272, // Fill in the appID that you get from ZEGOCLOUD Admin Console.
        appSign:
            'efca394b0259c48ff6e3bd4d8d2aa41b2949dc03ba9f79d5d3ba58e4966bcba7', // Fill in the appSign that you get from ZEGOCLOUD Admin Console.
        userID: userID.toString(),
        userName: userName.toString(),
        callID: chatId.toString(),
        // You can also use groupVideo/groupVoice/oneOnOneVoice to make more types of calls.
        config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall(),
      ),
    );
  }
}
