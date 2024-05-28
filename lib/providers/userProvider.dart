// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:haydos_app/models/userModel.dart';
import 'package:haydos_app/mongodb/DbExpressModel.dart';
import 'package:haydos_app/mongodb/DbFeedingModel.dart';
import 'package:haydos_app/mongodb/DbUserModel.dart';
import 'package:haydos_app/mongodb/mongodb.dart';
import 'package:haydos_app/screen/feeding.dart';
import 'package:haydos_app/screen/home.dart';
import 'package:haydos_app/screen/volunteering.dart';
import "package:mongo_dart/mongo_dart.dart" as M;
import 'package:shared_preferences/shared_preferences.dart';

class ResultMessage {
  String message;
  ResultMessage({required this.message});
}

class UserProvider with ChangeNotifier {
  bool isUserExist = false;
  late M.ObjectId id;
  String name = "";
  String phoneNumber = "";
  String email = "";
  String password = "";
  bool isOnDuty = false;

  Future<void> register(User user, BuildContext context) async {
    ResultMessage m = ResultMessage(message: "");
    var _id = M.ObjectId();
    final data = UserModel(_id, user.name, user.phoneNumber, user.email,
        user.password, user.isOnDuty);

    var result = await MongoDatabase.insert(data, m);
    if (result) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      id = _id;
      name = user.name;
      phoneNumber = user.phoneNumber;
      email = user.email;
      password = user.password;
      isOnDuty = false;
      isUserExist = true;

      await prefs.setString("email", email);
      await prefs.setString("password", password);

      Navigator.of(context).pop();
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomePage()));
    } else {
      isUserExist = false;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(m.message)));
    }
    notifyListeners();
  }

  Future<void> login(User user, BuildContext context) async {
    var _id = M.ObjectId();
    final data = UserModel(_id, "", "", user.email, user.password, false);

    final findUser = await MongoDatabase.getUser(data);
    if (findUser.isNotEmpty) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      id = findUser["_id"];
      email = findUser["email"];
      password = findUser["password"];
      name = findUser["name"];
      phoneNumber = findUser["phoneNumber"];
      isOnDuty = findUser["isOnDuty"];
      isUserExist = true;

      await prefs.setString("email", email);
      await prefs.setString("password", password);

      Navigator.of(context).pop();
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomePage()));
    } else {
      isUserExist = false;
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Something went wrong while logging in")));
    }
    notifyListeners();
  }

  Future<void> loginAutomatically() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String email = prefs.getString("email").toString();
    final String password = prefs.getString("password").toString();

    final data = UserModel(M.ObjectId(), "", "", email, password, false);
    final findUser = await MongoDatabase.getUser(data);

    if (findUser.isNotEmpty) {
      isUserExist = true;
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      id = findUser["_id"];
      this.email = findUser["email"];
      this.password = findUser["password"];
      name = findUser["name"];
      phoneNumber = findUser["phoneNumber"];
      isOnDuty = findUser["isOnDuty"];

      await prefs.setString("email", email);
      await prefs.setString("password", password);
    } else {
      isUserExist = false;
    }
    notifyListeners();
  }

  Future<void> logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("email", "");
    await prefs.setString("password", "");

    name = "";
    phoneNumber = "";
    email = "";
    password = "";
    isOnDuty = false;

    id;
    isUserExist = false;
    notifyListeners();
  }

  Future<void> volunteering(BuildContext context, List<int> selectedIndexList,
      List<FeedingModel> feeds, int type) async {
    bool completed = false;
    try {
      await MongoDatabase.updateUser(id, true);

      for (int e in selectedIndexList) {
        await MongoDatabase.updateFeeding(feeds[e].id, "proceed");

        var _id = M.ObjectId();
        ExpressModel express = ExpressModel(
            _id, id, feeds[e].id, type == 1 ? "car" : "walk", false, false);
        await MongoDatabase.insertExpress(express);
      }
      isOnDuty = true;
      completed = true;
      notifyListeners();
    } catch (e) {
      print(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Something went wrong while volunteering")));
    }

    if (completed) {
      Navigator.pop(context);
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const VolunteeringPage()));
      completed = false;
    }
  }

  Future<void> pressCompleted(
    BuildContext context,
    Map<String, dynamic> feedings,
    Map<String, dynamic> expresses,
    int numberOfItem,
  ) async {
    await MongoDatabase.completeExpress(expresses["_id"]);
    await MongoDatabase.updateFeeding(feedings["_id"], "done");

    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Operation Completed. Thank You <3")));

    if (numberOfItem == 1) {
      isOnDuty = false;
      await MongoDatabase.updateUser(id, false);
      notifyListeners();

      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const FeedingPage()));
    }
  }

  Future<void> pressCancel(
    BuildContext context,
    Map<String, dynamic> feedings,
    Map<String, dynamic> expresses,
    int numberOfItem,
  ) async {
    await MongoDatabase.cancelExpress(expresses["_id"]);
    await MongoDatabase.updateFeeding(feedings["_id"], "not done");

    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("Operation Cancelled")));

    if (numberOfItem == 1) {
      isOnDuty = false;
      await MongoDatabase.updateUser(id, false);
      notifyListeners();

      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const FeedingPage()));
    }
  }
}
