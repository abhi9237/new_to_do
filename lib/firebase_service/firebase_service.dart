import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_demo_app/presentation/all_user/all_user_modal/all_user_modal.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;

import '../presentation/add_todo/modal/add_todo_modal.dart';
import '../presentation/chat_screen/modal/get_messge_modal.dart';
import '../presentation/chat_screen/modal/send_message_modal.dart';
import '../presentation/home/modal/home_modal.dart';
import '../presentation/profile/modal/profile_modal.dart';
import '../presentation/signup/modal/sign_up_modal.dart';

class DatabaseService {
  static DatabaseService? _instance;
  DatabaseService._();
  factory DatabaseService() => _instance ??= DatabaseService._();

  storeSignUpUserData(
      {required String? firstName,
      required String? lastName,
      required String? phoneNumber,
      required String? email,
      required String? image,
      required String? uid}) async {
    final CollectionReference userCollection =
        FirebaseFirestore.instance.collection("AllUsers");

    DocumentReference documentReference = userCollection.doc(uid);
    SignupModal userSignup = SignupModal(
        phoneNumber: phoneNumber,
        firstName: firstName,
        email: email,
        authId: uid,
        lastName: lastName,
        image: image);
    SetOptions(merge: true);

    var newUser = userSignup.toJson();

    await documentReference.set(newUser);
  }

  Future storeDailyNotes({
    required String? title,
    required String? description,
    required String? uid,
    required DateTime? addedDate,
    required List<String>? images,
  }) async {
    final CollectionReference userCollection =
        FirebaseFirestore.instance.collection("All Notes");
    DocumentReference documentReference =
        userCollection.doc(uid).collection('myNotes').doc(title);
    log('SSSSSSSSS${images.toString()}');

    AddToDoModal addNotes = AddToDoModal(
        title: title,
        description: description,
        addedDate: addedDate,
        images: images,
        uid: uid);

    SetOptions(merge: true);
    var addUserNotes = addNotes.toJson();
    documentReference.set(addUserNotes);
  }

  Future<String> uploadProfileImageFirebaseStorage({File? fileName}) async {
    if (fileName != null) {
      String newFileName = path.basename(fileName.path);
      Reference firebaseStorageRef =
          FirebaseStorage.instance.ref().child('userProfilePic/$newFileName');
      await firebaseStorageRef.putFile(fileName);
      String url = await firebaseStorageRef.getDownloadURL();
      log(url);
      return url;
    }
    return '';
  }

  Future<String> uploadTodoImagesFirebaseStorage({File? fileName}) async {
    if (fileName != null) {
      String newFileName = path.basename(fileName.path);
      Reference firebaseStorageRef =
          FirebaseStorage.instance.ref().child('todoImages/$newFileName');
      await firebaseStorageRef.putFile(fileName);
      String url = await firebaseStorageRef.getDownloadURL();
      log(url);
      return url;
    }
    return '';
  }

  Future<List<GetToDoModal>> getTodoData({String? uid}) async {
    List<GetToDoModal> toDoList = <GetToDoModal>[];
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('All Notes')
          .doc(uid)
          .collection("myNotes")
          .orderBy("title")
          .get();
      for (var item in snapshot.docs) {
        var data = GetToDoModal.fromJson(item.data());
        toDoList.add(data);
      }
      return toDoList;
    } catch (e) {
      log(e.toString());
      return [];
    }
  }

  editData(
      {String? oldTitle,
      required String title,
      required String description,
      String? uid,
      List<String>? images}) async {
    AddToDoModal addNotes = AddToDoModal(
        title: title,
        description: description,
        uid: uid,
        images: images,
        addedDate: DateTime.now());
    await FirebaseFirestore.instance
        .collection('All Notes')
        .doc(uid)
        .collection('myNotes')
        .doc(oldTitle)
        .update(addNotes.toJson())
        .then(
          (v) {},
        )
        .catchError((e) {
      log(e.toString());
    });
  }

  deleteData({
    String? deleteIndexId,
    String? uid,
  }) async {
    await FirebaseFirestore.instance
        .collection('All Notes')
        .doc(uid)
        .collection('myNotes')
        .doc(deleteIndexId)
        .delete();
  }

  Future<GetUserProfileModal> fetchUserDetails({String? uid}) async {
    var data;
    final snapshot =
        await FirebaseFirestore.instance.collection('AllUsers').doc(uid).get();
    if (snapshot.data() != null) {
      data = GetUserProfileModal.fromJson(snapshot.data()!);

      return data;
    }
    return data;
  }

  Future updateUserProfileData(
      {String? uid,
      String? firstName,
      String? lastName,
      String? email,
      String? phoneNumber,
      String? image}) async {
    SignupModal signupModal = SignupModal(
        firstName: firstName,
        lastName: lastName,
        image: image,
        email: email,
        phoneNumber: phoneNumber,
        authId: uid);
    await FirebaseFirestore.instance
        .collection('AllUsers')
        .doc(uid)
        .update(signupModal.toJson())
        .then(
          (v) {},
        )
        .catchError((e) {
      log(e.toString());
    });
  }

  // Future<GetUserProfileModal>
  Future<List<AllUserModal>> fetchAllUserDetails({String? uid}) async {
    List<AllUserModal> allUserList = <AllUserModal>[];
    final snapshot =
        await FirebaseFirestore.instance.collection('AllUsers').get();
    log('All User Details${snapshot.docs.toString()}');
    if (snapshot.docs != []) {
      for (var i in snapshot.docs) {
        log(i.data()['uid']);
        log(uid.toString());
        if (i.data()['uid'].toString().toLowerCase() !=
            uid.toString().toLowerCase()) {
          var data = AllUserModal.fromJson(i.data());
          allUserList.add(data);
        }
      }
      return allUserList;
    }
    return allUserList;
  }

  sendMessageFirebase(
      {String? chatId,
      String? name,
      DateTime? sendAt,
      String? message,
      String? reciverId}) async {
    log(chatId.toString());
    SendMessageModal sendMessageModal = SendMessageModal(
        name: name,
        sendAt: sendAt,
        text: message,
        reciverId: reciverId,
        chatId: chatId);
    await FirebaseFirestore.instance
        .collection('chat')
        .doc(chatId)
        .collection('message')
        .add(sendMessageModal.toJson());
  }

  Future<List<GetMessagesModal>> getChatMessages({String? chatId}) async {
    List<GetMessagesModal> allMessageList = <GetMessagesModal>[];
    try {
      log(chatId.toString());
      final snapshot = await FirebaseFirestore.instance
          .collection('chat')
          .doc(chatId)
          .collection('message')
          .orderBy('sendAt', descending: true)
          .get();
      if (snapshot.docs != []) {
        for (var i in snapshot.docs) {
          log(i.data().toString());
          var data = GetMessagesModal.fromJson(i.data());
          log(data.toString());
          allMessageList.add(data);
        }
      }
    } catch (e) {
      log(e.toString());
    }
    log('List===${allMessageList.length.toString()}');
    return allMessageList;
  }

  sendNotification({String? deviceToken, String? message}) async {
    var data = {
      'to': deviceToken ?? '',
      'notification': {
        'title': 'Chat',
        'body': message,
        "sound": "jetsons_doorbell.mp3"
      },
      'android': {
        'notification': {
          'notification_count': 0,
        },
      },
      // 'data' : {
      //   'type' : 'msj' ,
      //   'id' : 'Asif Taj'
      // }
    };

    await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
        body: jsonEncode(data),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization':
              'key=AAAAp9pXDFM:APA91bGhBeMCUABE2PXjl9UqodAZ2WdV_UI6PoiwdCzYaT8KeZmBKZszc01CD1GgN0OAJ1w3sNw9IVISyKhrrxQLASHizenGJUr2hjzoPjbjFu0HAx1CTk0l8Ut95ZENAQyRKm6hrltV'
        }).then((value) {
      if (kDebugMode) {
        print(value.body.toString());
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print(error);
      }
    });
  }
}
