import 'package:flutter/material.dart';
import 'package:haydos_app/data/adoptionData.dart';
import 'dart:math' as math;

import 'package:url_launcher/url_launcher.dart';

class AdoptionPage extends StatefulWidget {
  const AdoptionPage({super.key});

  @override
  State<AdoptionPage> createState() => _AdoptionPageState();
}

class Adoption {
  late String image;
  late String url;
  late bool isAdopted;

  Adoption(this.image, this.url, this.isAdopted);

  String getImage() {
    return image;
  }

  String getUrl() {
    return url;
  }

  bool getIsAdopted() {
    return isAdopted;
  }
}

class _AdoptionPageState extends State<AdoptionPage> {
  bool stringToBoolean(String value) {
    return value.toLowerCase() == 'true';
  }

  late List<Adoption> adoptions = [];
  @override
  void initState() {
    super.initState();

    for (Map<String, Object> e in adoptionData) {
      adoptions.add(Adoption(e["image"].toString(), e["url"].toString(),
          stringToBoolean(e["isAdopted"].toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffeaffce),
        toolbarHeight: 80,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Adoptions"),
            Image(
                image: AssetImage("lib/assets/Haydos_App_Logo.png"),
                height: 80),
          ],
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xffeaffce), Color(0xfffffca1)])),
        child: Center(
          child: SizedBox(
            width: 400,
            child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                ),
                itemCount: adoptions.length,
                itemBuilder: (context, index) {
                  Adoption adoption = adoptions[index];
                  return GestureDetector(
                    onTap: () async {
                      final Uri url = Uri.parse(adoption.url);
                      if (!await launchUrl(url)) {
                        throw Exception('Could not launch');
                      }
                    },
                    child: Center(
                        child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Image(image: AssetImage(adoption.image)),
                        adoption.isAdopted
                            ? Transform.rotate(
                                angle: -45 * math.pi / 180,
                                child: const Center(
                                  child: Text(
                                    "Adopted",
                                    style: TextStyle(
                                        fontSize: 72,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green,
                                        fontStyle: FontStyle.italic),
                                  ),
                                ),
                              )
                            : const SizedBox(),
                      ],
                    )),
                  );
                }),
          ),
        ),
      ),
    );
  }
}
