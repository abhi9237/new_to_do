import 'package:get/get.dart';

class VideoController extends GetxController {
  // RtcEngine? engine;
  // bool isJoined = false,
  //     switchCamera = true,
  //     switchRender = true,
  //     openCamera = true,
  //     muteCamera = false,
  //     muteAllRemoteVideo = false;
  // Set<int> remoteUid = {};
  // late TextEditingController controller;
  // bool isUseFlutterTexture = false;
  // bool isUseAndroidSurfaceView = false;
  // ChannelProfileType channelProfileType =
  //     ChannelProfileType.channelProfileLiveBroadcasting;
  // late final RtcEngineEventHandler rtcEngineEventHandler;
  //
  // Future<void> _initEngine() async {
  //   rtcEngineEventHandler = RtcEngineEventHandler(
  //     onError: (ErrorCodeType err, String msg) {
  //       log('[onError] err: $err, msg: $msg');
  //     },
  //     onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
  //       log('[onJoinChannelSuccess] connection: ${connection.toJson()} elapsed: $elapsed');
  //
  //       isJoined = true;
  //       update();
  //     },
  //     onUserJoined: (RtcConnection connection, int rUid, int elapsed) {
  //       log('[onUserJoined] connection: ${connection.toJson()} remoteUid: $rUid elapsed: $elapsed');
  //
  //       remoteUid.add(rUid);
  //       update();
  //     },
  //     onUserOffline:
  //         (RtcConnection connection, int rUid, UserOfflineReasonType reason) {
  //       log('[onUserOffline] connection: ${connection.toJson()}  rUid: $rUid reason: $reason');
  //
  //       remoteUid.removeWhere((element) => element == rUid);
  //       update();
  //     },
  //     onLeaveChannel: (RtcConnection connection, RtcStats stats) {
  //       log('[onLeaveChannel] connection: ${connection.toJson()} stats: ${stats.toJson()}');
  //
  //       isJoined = false;
  //       remoteUid.clear();
  //       update();
  //     },
  //     onRemoteVideoStateChanged: (RtcConnection connection, int remoteUid,
  //         RemoteVideoState state, RemoteVideoStateReason reason, int elapsed) {
  //       log('[onRemoteVideoStateChanged] connection: ${connection.toJson()} remoteUid: $remoteUid state: $state reason: $reason elapsed: $elapsed');
  //     },
  //   );
  //
  //   engine?.registerEventHandler(rtcEngineEventHandler);
  //
  //   await engine?.enableVideo();
  //   await engine?.startPreview();
  // }
  //
  // Future<void> dispose() async {
  //   engine?.unregisterEventHandler(rtcEngineEventHandler);
  //   await engine?.leaveChannel();
  //   await engine?.release();
  // }
  //
  // Future<void> joinChannel() async {
  //   await engine?.joinChannel(
  //     token: StringConstant.agoraToken,
  //     channelId: controller.text,
  //     uid: Get.find<GetStorageData>().userId,
  //     options: ChannelMediaOptions(
  //       channelProfile: channelProfileType,
  //       clientRoleType: ClientRoleType.clientRoleBroadcaster,
  //     ),
  //   );
  // }
  //
  // Future<void> leaveChannel() async {
  //   await engine?.leaveChannel();
  //
  //   openCamera = true;
  //   muteCamera = false;
  //   muteAllRemoteVideo = false;
  //   update();
  // }
  //
  // Future<void> switchMyCamera() async {
  //   await engine?.switchCamera();
  //
  //   switchCamera = !switchCamera;
  //   update();
  // }
  //
  // openMyCamera() async {
  //   await engine?.enableLocalVideo(!openCamera);
  //
  //   openCamera = !openCamera;
  //   update();
  // }
  //
  // muteLocalVideoStream() async {
  //   await engine?.muteLocalVideoStream(!muteCamera);
  //
  //   muteCamera = !muteCamera;
  //   update();
  // }
  //
  // muteAllRemoteVideoStreams() async {
  //   await engine?.muteAllRemoteVideoStreams(!muteAllRemoteVideo);
  //
  //   muteAllRemoteVideo = !muteAllRemoteVideo;
  //   update();
  // }
  //
  // createEngine() async {
  //   engine = createAgoraRtcEngine();
  //   await engine?.initialize(const RtcEngineContext(
  //     appId: '8cb838ee12fa4d07a3e39fcf68c017f4',
  //   ));
  //   log('done');
  // }

  @override
  void onClose() {
    super.onClose();
    dispose();
  }

  @override
  void onInit() {
    super.onInit();

    // createEngine();
    //
    // controller = TextEditingController(text: StringConstant.channelId);
    // _initEngine();
  }
}
