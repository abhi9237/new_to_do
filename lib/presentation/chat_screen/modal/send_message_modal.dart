class SendMessageModal {
  String? text;
  DateTime? sendAt;
  String? name;
  String? reciverId;
  String? chatId;
  SendMessageModal({
    this.text,
    this.sendAt,
    this.name,
    this.reciverId,
    this.chatId,
  });

  SendMessageModal.fromJson(Map<String, dynamic> json) {
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
