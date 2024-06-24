import 'dart:developer';

import 'package:firebase_demo_app/common/get_storage.dart';
import 'package:firebase_demo_app/firebase_service/firebase_service.dart';
import 'package:firebase_demo_app/presentation/chat_screen/ui/chat_screen.dart';
import 'package:get/get.dart';

import '../all_user_modal/all_user_modal.dart';

class AllUserController extends GetxController {
  RxList<AllUserModal> allUserList = <AllUserModal>[].obs;

  allUserDetails() async {
    allUserList.value = await DatabaseService()
        .fetchAllUserDetails(uid: Get.find<GetStorageData>().userId);
  }

  onTapNavigate({int? index}) {
    log(allUserList[index ?? 0].uid.toString());
    Get.to(() => ChatScreen(
          name: allUserList[index ?? 0].firstName,
          recieverId: allUserList[index ?? 0].uid,
        ));
  }

  @override
  void onInit() {
    super.onInit();
    allUserDetails();
  }
}
