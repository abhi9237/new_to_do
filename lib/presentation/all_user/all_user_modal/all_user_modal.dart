class AllUserModal {
  String? firstName;
  String? lastName;
  String? email;
  String? phoneNumber;
  String? image;
  String? uid;
  AllUserModal({
    this.firstName,
    this.lastName,
    this.email,
    this.phoneNumber,
    this.image,
    this.uid,
  });

  AllUserModal.fromJson(Map<String, dynamic> json) {
    firstName = json["firstName"];
    lastName = json["lastName"];
    email = json["email"];
    phoneNumber = json["phoneNumber"];
    image = json["image"];
    uid = json["uid"];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["firstName"] = firstName;
    data["lastName"] = lastName;
    data["email"] = email;
    data["phoneNumber"] = phoneNumber;
    data["image"] = image;
    data["uid"] = uid;
    return data;
  }
}
