import 'package:flutter/material.dart';
import 'package:haydos_app/data/petData.dart';
import 'package:haydos_app/models/petModel.dart';

class PetProvider with ChangeNotifier {
  List<Pet> pets = [];

  void initState() {
    pets = [];
  }

  void listAllPets() {
    initState();
    for (Map<String, Object> e in petData) {
      pets.add(Pet(
          e["name"].toString(),
          e["image"].toString(),
          e["gender"].toString(),
          int.parse(e["age"].toString()),
          e["health_condition"].toString(),
          e["report"].toString(),
          e["funfact"].toString()));
    }
  }
}
