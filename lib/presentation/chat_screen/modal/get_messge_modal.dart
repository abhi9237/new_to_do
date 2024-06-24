import 'package:cloud_firestore/cloud_firestore.dart';

class GetMessagesModal {
  String? text;
  Timestamp? sendAt;
  String? name;
  String? reciverId;
  String? chatId;
  GetMessagesModal({
    this.text,
    this.sendAt,
    this.name,
    this.reciverId,
    this.chatId,
  });

  GetMessagesModal.fromJson(Map<String, dynamic> json) {
    text = json["text"];
    sendAt = json["sendAt"];
    name = json["name"];
    reciverId = json["reciverId"];
    chatId = json["chatId"];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["name"] = name;
    data["text"] = text;
    data["sendAt"] = sendAt;
    data["reciverId"] = reciverId;
    data["chatId"] = chatId;

    return data;
  }
}
