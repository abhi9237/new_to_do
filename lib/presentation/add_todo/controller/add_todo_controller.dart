import 'dart:developer';
import 'dart:io';

import 'package:firebase_demo_app/common/common_method.dart';
import 'package:firebase_demo_app/common/get_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

import '../../../firebase_service/firebase_service.dart';
import '../../home/controller/home_controller.dart';
import '../../home/modal/home_modal.dart';

class AddTodoController extends GetxController {
  AddTodoController({this.editToDoData, this.callFrom = ''});
  RxList<GetToDoModal> toDoList = <GetToDoModal>[].obs;

  GetToDoModal? editToDoData;
  String? callFrom;

  var titleController = TextEditingController().obs;
  var descriptionController = TextEditingController().obs;

  ImagePicker imagePicker = ImagePicker();
  RxList<File> images = <File>[].obs;
  RxList<String> editImages = <String>[].obs;

  var isLoading = false.obs;

  editData() async {
    if (editToDoData != null) {
      titleController.value.text = editToDoData?.title ?? '';
      descriptionController.value.text = editToDoData?.description ?? '';

      for (var i in editToDoData!.images ?? []) {
        downloadImage(i).then((value) => images.add(value ?? File('')));
      }

      // images.value =  (editToDoData!.images ?? []).map((e) => ).toList();
    }
  }

  pickImagesList({ImageSource? imageSource}) async {
    await imagePicker.pickMultiImage().then((value) async {
      if (value.isNotEmpty && value.length > 3) {
        CustomToast.showToast('Please select only three images',
            bgColor: Colors.blue);
        // image = await compressImage(value);
        update();
      } else if (value.isNotEmpty) {
        for (var i in value) {
          File image = await compressImage(i);
          images.add(image);
          log('Length${images.toString()}');
          // DatabaseService().uploadImageFirebaseStorage(fileName: image);
        }
      }
    });
  }

  clearController() {
    titleController.value.clear();
    descriptionController.value.clear();
    images.clear();
  }

  onTapAddTodo() async {
    if (titleController.value.text.trim().isEmpty) {
      CustomToast.showToast('Please enter title', bgColor: Colors.blue);
    } else if (descriptionController.value.text.trim().isEmpty) {
      CustomToast.showToast('Please enter description', bgColor: Colors.blue);
    } else if (toDoList.any((element) => element.title!
        .toLowerCase()
        .contains(titleController.value.text.toLowerCase().trim()))) {
      CustomToast.showToast('Title is already exist please add another title',
          bgColor: Colors.blue);
    } else if (images.isEmpty) {
      CustomToast.showToast('Please add one image', bgColor: Colors.blue);
    } else {
      isLoading.value = true;
      List<String> todoImages = [];
      todoImages = await Future.wait(
          images.map((i) => DatabaseService().uploadTodoImagesFirebaseStorage(
                fileName: i,
              )));

      log('Images List${todoImages.toString()}');
      log('Get.find<GetStorageData>().userId${Get.find<GetStorageData>().userId}');
      DatabaseService()
          .storeDailyNotes(
        title: titleController.value.text.trim(),
        description: descriptionController.value.text.trim(),
        uid: Get.find<GetStorageData>().userId,
        addedDate: DateTime.now(),
        images: todoImages.map((e) => e).toList(),
      )
          .then((value) {
        isLoading.value = false;
        clearController();
        CustomToast.showToast('Data Added Successfully', bgColor: Colors.blue);
        update();
      }).onError((error, stackTrace) {
        isLoading.value = false;
        log(error.toString());
        CustomToast.showToast(error.toString(), bgColor: Colors.blue);
      });
    }
  }

  onTapEdit(BuildContext context) async {
    if (titleController.value.text.trim().isEmpty) {
      CustomToast.showToast('Please enter title', bgColor: Colors.blue);
    } else if (descriptionController.value.text.trim().isEmpty) {
      CustomToast.showToast('Please enter description', bgColor: Colors.blue);
    } else {
      isLoading.value = true;
      List<String> todoImages = await Future.wait(
          images.map((i) => DatabaseService().uploadTodoImagesFirebaseStorage(
                fileName: i,
              )));

      log('Images List${todoImages.toString()}');
      DatabaseService()
          .editData(
        oldTitle: editToDoData?.title,
        title: titleController.value.text.trim(),
        description: descriptionController.value.text.trim(),
        uid: Get.find<GetStorageData>().userId,
        images: todoImages.map((e) => e).toList(),
      )
          .then((value) {
        isLoading.value = false;
        update();
        Get.find<HomeController>().fetchData();
        Navigator.of(context).pop();
        clearController();
      }).onError((error, stackTrace) {
        isLoading.value = false;
        log(error.toString());
        CustomToast.showToast(error.toString(), bgColor: Colors.blue);
      });
    }
  }

  Future<void> fetchData() async {
    toDoList.value = await DatabaseService()
        .getTodoData(uid: Get.find<GetStorageData>().userId);
    update();
  }

  Future<File?> downloadImage(String img) async {
    File? fileImage;
    try {
      // Fetch image data from the URL
      final response = await http.get(Uri.parse(img));

      if (response.statusCode == 200) {
        // Get the document directory path
        final directory = await getApplicationDocumentsDirectory();

        // Create the full file path
        final filePath = path.join(directory.path, path.basename(img));

        // Save the image file
        final fileImage = File(filePath);
        await fileImage.writeAsBytes(response.bodyBytes);
        print('File saved at $filePath');
        return fileImage;
      } else {
        print('Error: ${response.statusCode}');
        return fileImage;
      }
    } catch (e) {
      print('Error: $e');
    }
    return null;
  }

  @override
  void onInit() {
    super.onInit();
    fetchData();
    if (callFrom == 'edit') {
      editData();
    }
  }
}
