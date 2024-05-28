import 'dart:convert';

import 'package:mongo_dart/mongo_dart.dart';

ExpressModel mongoDbModelFromJson(String str) =>
    ExpressModel.fromJson(jsonDecode(str));

String mongoDbModelToJson(ExpressModel data) => json.encode(data.toJson());

class ExpressModel {
  ObjectId id;
  ObjectId userId;
  ObjectId feedingId;
  String expressType;
  bool isCompleted;
  bool isCanceled;

  ExpressModel(
    this.id,
    this.userId,
    this.feedingId,
    this.expressType,
    this.isCompleted,
    this.isCanceled,
  );

  factory ExpressModel.fromJson(Map<String, dynamic> json) => ExpressModel(
        json["_id"],
        json["userId"],
        json["feedingId"],
        json["expressType"],
        json["isCompleted"],
        json["isCanceled"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "userId": userId,
        "feedingId": feedingId,
        "expressType": expressType,
        "isCompleted": isCompleted,
        "isCanceled": isCanceled,
      };
}
