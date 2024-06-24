import 'package:firebase_demo_app/common/string_constant.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../presentation/login/view/login_page.dart';

class GetStorageData extends GetxController {
  GetStorage box = GetStorage();

  final _userId = ''.obs;
  final _token = ''.obs;
  final _userName = ''.obs;

  init() async {
    _userId.value = box.read(StringConstant.userId) ?? '';
    _token.value = box.read(StringConstant.token) ?? '';
    _userName.value = box.read(StringConstant.userName) ?? '';
  }

  get userId => _userId.value;
  get token => _token.value;
  get userName => _userName.value;

  void setUserId(String value) {
    _userId.value = value;
    setPref(StringConstant.userId, value);
    update();
  }

  void setUserName(String value) {
    _userName.value = value;
    setPref(StringConstant.userName, value);
    update();
  }

  void setToken(String value) {
    _token.value = value;
    setPref(StringConstant.token, value);
    update();
  }

  void setPref(String key, dynamic value) async {
    await box.write(key, value);
  }

  void logOut() async {
    await box.erase();
    Get.offAll(LoginScreen());
  }
}
