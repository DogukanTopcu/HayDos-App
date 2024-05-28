import 'package:flutter/material.dart';
import 'package:haydos_app/data/missingData.dart';
import 'dart:math' as math;

import 'package:url_launcher/url_launcher.dart';

class MissingsPage extends StatefulWidget {
  const MissingsPage({super.key});

  @override
  State<MissingsPage> createState() => _MissingsPageState();
}

class Missing {
  late String image;
  late String url;
  late bool isFound;

  Missing(this.image, this.url, this.isFound);

  String getImage() {
    return image;
  }

  String getUrl() {
    return url;
  }

  bool getIsFound() {
    return isFound;
  }
}

class _MissingsPageState extends State<MissingsPage> {
  bool stringToBoolean(String value) {
    return value.toLowerCase() == 'true';
  }

  late List<Missing> missings = [];
  @override
  void initState() {
    super.initState();

    for (Map<String, Object> e in missingData) {
      missings.add(Missing(e["image"].toString(), e["url"].toString(),
          stringToBoolean(e["isFound"].toString())));
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
            Text("Missings"),
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
                itemCount: missings.length,
                itemBuilder: (context, index) {
                  Missing adoption = missings[index];
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
                        adoption.isFound
                            ? Transform.rotate(
                                angle: -45 * math.pi / 180,
                                child: const Center(
                                  child: Text(
                                    "Found",
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
