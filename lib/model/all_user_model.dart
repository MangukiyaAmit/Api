// To parse this JSON data, do
//
//     final allUserModel = allUserModelFromJson(jsonString);

import 'dart:convert';

AllUserModel allUserModelFromJson(String str) =>
    AllUserModel.fromJson(json.decode(str));

String allUserModelToJson(AllUserModel data) => json.encode(data.toJson());

class AllUserModel {
  AllUserModel({
    this.status,
    this.message,
    this.userCount,
    this.users,
  });

  bool? status;
  String? message;
  int? userCount;
  List<User>? users;

  factory AllUserModel.fromJson(Map<String, dynamic> json) => AllUserModel(
        status: json["status"],
        message: json["message"],
        userCount: json["user_count"],
        users: List<User>.from(json["users"].map((x) => User.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "user_count": userCount,
        "users": List<dynamic>.from(users!.map((x) => x.toJson())),
      };
}

class User {
  User({
    this.id,
    this.firstName,
    this.lastName,
    this.avatar,
    this.username,
    this.created,
  });

  String? id;
  String? firstName;
  String? lastName;
  String? avatar;
  String? username;
  String? created;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        avatar: json["avatar"],
        username: json["username"],
        created: json["created"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "avatar": avatar,
        "username": username,
        "created": created,
      };
}
