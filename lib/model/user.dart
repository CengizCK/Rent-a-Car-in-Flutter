import 'dart:convert';

class UserModel {
  UserModel(
      {required this.username,
      required this.email,
      required this.password,
      this.admin = false,
      required this.tc,
      required this.tel});
  String username;
  String email;
  String password;
  bool admin;
  String tc;
  String tel;

  factory UserModel.fromJson(json) => UserModel(
      username: json["username"] ?? "",
      email: json["email"] ?? "",
      password: json["password"] ?? "",
      admin: json["admin"] ?? false,
      tc: json["tc"] ?? "",
      tel: json["tel"] ?? "");

  toJson() {
    return {
      "username": username,
      "email": email,
      "password": password,
      "admin": admin,
      "tc": tc,
      "tel": tel
    };
  }
}
