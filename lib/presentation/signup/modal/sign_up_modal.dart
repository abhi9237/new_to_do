class SignupModal {
  String? firstName;
  String? lastName;
  String? email;
  String? phoneNumber;
  String? authId;
  String? image;

  SignupModal(
      {this.firstName,
      this.lastName,
      this.email,
      this.phoneNumber,
      this.image,
      this.authId});

  SignupModal.fromJson(Map<String, dynamic> json) {
    firstName = json["firstName"];
    lastName = json["lastName"];
    email = json["email"];
    authId = json["uid"];
    image = json["image"];
    phoneNumber = json["phoneNumber"];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data["firstName"] = firstName;
    data["lastName"] = lastName;
    data["email"] = email;
    data["uid"] = authId;
    data["image"] = image;
    data["phoneNumber"] = phoneNumber;

    return data;
  }
}
