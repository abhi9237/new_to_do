class GetUserProfileModal {
  String? firstName;
  String? lastName;
  String? email;
  String? phoneNumber;
  String? image;
  GetUserProfileModal({
    this.firstName,
    this.lastName,
    this.email,
    this.phoneNumber,
    this.image,
  });

  GetUserProfileModal.fromJson(Map<String, dynamic> json) {
    firstName = json["firstName"];
    lastName = json["lastName"];
    email = json["email"];
    phoneNumber = json["phoneNumber"];
    image = json["image"];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["firstName"] = firstName;
    data["lastName"] = lastName;
    data["email"] = email;
    data["phoneNumber"] = phoneNumber;
    data["image"] = image;
    return data;
  }
}
