class AddToDoModal {
  String? title;
  String? description;
  DateTime? addedDate;
  String? uid;
  List<String>? images;
  AddToDoModal({
    this.images,
    this.title,
    this.addedDate,
    this.description,
    this.uid,
  });

  AddToDoModal.fromJson(Map<String, dynamic> json) {
    title = json["title"];
    description = json["description"];
    addedDate = json["addedDate"];
    uid = json["uid"];
    if (json['images'] != null) {
      images = [];
      json['images'].forEach((v) {
        images!.add(v);
      });
    }
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data["title"] = title;
    data["description"] = description;
    data["addedDate"] = addedDate;
    data["uid"] = uid;
    if (images != null) {
      data['images'] = images!.map((v) => v).toList();
    }

    return data;
  }
}
