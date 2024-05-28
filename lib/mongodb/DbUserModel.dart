import 'dart:convert';

import 'package:mongo_dart/mongo_dart.dart';

UserModel mongoDbModelFromJson(String str) =>
    UserModel.fromJson(jsonDecode(str));

String mongoDbModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  ObjectId id;
  String name;
  String phoneNumber;
  String email;
  String password;
  bool isOnDuty;

  UserModel(this.id, this.name, this.phoneNumber, this.email, this.password,
      this.isOnDuty);

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        json["_id"],
        json["name"],
        json["phoneNumber"],
        json["email"],
        json["password"],
        json["isOnDuty"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "email": email,
        "password": password,
        "phoneNumber": phoneNumber,
        "isOnDuty": isOnDuty,
      };
}
