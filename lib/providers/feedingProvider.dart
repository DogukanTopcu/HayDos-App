import 'package:flutter/material.dart';
import 'package:haydos_app/data/feedingZoneData.dart';
import 'package:haydos_app/models/feedingModel.dart';
import 'package:haydos_app/mongodb/mongodb.dart';

class FeedingProvider with ChangeNotifier {
  List<Feeding> feedings = [];

  void initState() {
    feedings = [];
  }

  void listAllFeedings() {
    initState();
    for (Map<String, dynamic> e in feedingZoneData) {
      feedings.add(Feeding(
        id: int.parse(e["id"].toString()),
        name: e["name"].toString(),
        location: e["location"].toString(),
        status: e["status"].toString(),
      ));
    }
  }

  Future<List<Feeding>> getFeedings() async {
    initState();
    List<Map<String, dynamic>> result = await MongoDatabase.getAllFeedings();
    for (Map<String, dynamic> e in result) {
      feedings.add(Feeding(
        id: int.parse(e["id"].toString()),
        name: e["name"].toString(),
        location: e["location"].toString(),
        status: e["status"].toString(),
      ));
    }
    return feedings;
  }

  void refreshFeedings() {
    initState();
    for (Map<String, dynamic> e in feedingZoneData) {
      feedings.add(Feeding(
        id: int.parse(e["id"].toString()),
        name: e["name"].toString(),
        location: e["location"].toString(),
        status: e["status"].toString(),
      ));
    }
  }
}
