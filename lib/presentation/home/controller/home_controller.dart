import 'package:firebase_demo_app/common/get_storage.dart';
import 'package:get/get.dart';

import '../../../firebase_service/firebase_service.dart';
import '../../add_todo/view/add_todo.dart';
import '../modal/home_modal.dart';

class HomeController extends GetxController {
  RxList<GetToDoModal> toDoList = <GetToDoModal>[].obs;
  RxBool isLoading = false.obs;

  Future<void> fetchData() async {
    isLoading.value = true;
    toDoList.value = await DatabaseService()
        .getTodoData(uid: Get.find<GetStorageData>().userId)
        .whenComplete(() => isLoading.value = false);
    update();
  }

  editTodo({GetToDoModal? getToDoData}) {
    Get.to(() => AddTodoScreen(
          callFrom: 'edit',
          getToDoModal: getToDoData,
        ));
  }

  onTapDelete({String? title, String? uid, int? index}) async {
    DatabaseService().deleteData(uid: uid, deleteIndexId: title);
    toDoList.removeAt(index ?? 0);
    toDoList.refresh();
    update();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    fetchData();
    super.onInit();
  }
}
