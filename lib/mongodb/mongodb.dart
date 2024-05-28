// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:haydos_app/mongodb/DbExpressModel.dart';
import 'package:haydos_app/mongodb/constants.dart';
import 'package:haydos_app/mongodb/DbUserModel.dart';
import 'package:haydos_app/providers/userProvider.dart';
import 'package:mongo_dart/mongo_dart.dart';

class MongoDatabase {
  static var db, userCollection, feedingCollection, expressCollection;
  static connect() async {
    db = await Db.create(MONGODB_URL);
    await db.open();
    userCollection = db.collection(USER_COLLECTION);
    feedingCollection = db.collection(FEEDING_COLLECTION);
    expressCollection = db.collection(EXPRESS_COLLECTION);
  }

  // For User Data
  static Future<Map<String, dynamic>> getUser(UserModel data) async {
    List<Map<String, dynamic>> result = await userCollection
        .find(where.eq("email", data.email).eq("password", data.password))
        .toList();

    if (result.isNotEmpty) {
      return result[0];
    }
    return <String, dynamic>{};
  }

  static Future<bool> insert(UserModel data, ResultMessage m) async {
    try {
      List<Map<String, dynamic>> find =
          await userCollection.find(where.eq("email", data.email)).toList();

      if (find.isNotEmpty) {
        m.message = "User is exist";
        return false;
      } else {
        var result = await userCollection.insertOne(data.toJson());
        if (result.isSuccess) {
          return true;
        } else {
          m.message = "Something wrong while sign up";
          return false;
        }
      }
    } catch (e) {
      m.message = "Something wrong while sign up";
      return false;
    }
  }

  static Future<void> updateUser(ObjectId id, bool isOnDuty) async {
    var data = await userCollection.findOne({"_id": id});
    data["isOnDuty"] = isOnDuty;
    await userCollection.replaceOne({"_id": id}, data);
  }

  // For Feeding Data
  static Future<List<Map<String, dynamic>>> getAllFeedings() async {
    final arrayData = await feedingCollection.find().toList();
    return arrayData;
  }

  static Future<void> updateFeeding(ObjectId feedingId, String status) async {
    var data = await feedingCollection.findOne({"_id": feedingId});
    data["status"] = status;
    await feedingCollection.replaceOne({"_id": feedingId}, data);
  }

  static Future<Map<String, dynamic>> getFeedingById(ObjectId id) async {
    var data = await feedingCollection.findOne({"_id": id});
    return data;
  }

  // For Express Data
  static Future<void> insertExpress(ExpressModel e) async {
    await expressCollection.insertOne(e.toJson());
  }

  static Future<List<Map<String, dynamic>>> getExpressByUserId(
      ObjectId id) async {
    final arrayData = await expressCollection
        .find(where
            .eq("userId", id)
            .eq("isCompleted", false)
            .eq("isCanceled", false))
        .toList();
    return arrayData;
  }

  static Future<void> cancelExpress(ObjectId id) async {
    var data = await expressCollection.findOne({"_id": id});
    data["isCanceled"] = true;
    await expressCollection.replaceOne({"_id": id}, data);
  }

  static Future<void> completeExpress(ObjectId id) async {
    var data = await expressCollection.findOne({"_id": id});
    data["isCompleted"] = true;
    await expressCollection.replaceOne({"_id": id}, data);
  }
}
