import 'dart:convert';

import 'package:mongo_dart/mongo_dart.dart';

FeedingModel mongoDbModelFromJson(String str) =>
    FeedingModel.fromJson(jsonDecode(str));

String mongoDbModelToJson(FeedingModel data) => json.encode(data.toJson());

class FeedingModel {
  ObjectId id;
  String name;
  String location;
  String status;

  FeedingModel(this.id, this.name, this.location, this.status);

  factory FeedingModel.fromJson(Map<String, dynamic> json) => FeedingModel(
        json["_id"],
        json["name"],
        json["location"],
        json["status"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "location": location,
        "status": status,
      };
}
