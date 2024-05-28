import 'package:flutter/material.dart';
import 'package:haydos_app/components/vetData.dart';
import 'package:haydos_app/data/vetsData.dart';
import 'package:url_launcher/url_launcher.dart';

class CallVets extends StatefulWidget {
  const CallVets({super.key});

  @override
  State<CallVets> createState() => _CallVetsState();
}

class Vet {
  String vetName;
  String phoneNumber;
  String location;
  String url;
  double rate;

  Vet(this.vetName, this.phoneNumber, this.location, this.url, this.rate);
}

class _CallVetsState extends State<CallVets> {
  List<Vet> vets = [];
  @override
  void initState() {
    super.initState();

    for (Map<String, dynamic> e in vetsData) {
      vets.add(Vet(e["vetName"].toString(), e["phoneNumber"].toString(),
          e["location"].toString(), e["url"].toString(), e["rate"] as double));
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
            Text("Call Vets"),
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
          child: Container(
              constraints: const BoxConstraints(maxWidth: 450),
              padding: const EdgeInsets.all(20),
              child: Center(
                child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      childAspectRatio: 1.7,
                    ),
                    itemCount: vets.length,
                    itemBuilder: (context, index) {
                      Vet newVet = vets[index];
                      return GestureDetector(
                        onTap: () async {
                          final Uri url = Uri.parse(newVet.url);
                          if (!await launchUrl(url)) {
                            throw Exception('Could not launch');
                          }
                        },
                        child: VetData(
                            vetName: newVet.vetName,
                            rate: newVet.rate,
                            phoneNumber: newVet.phoneNumber,
                            location: newVet.location),
                      );
                    }),
              )),
        ),
      ),
    );
  }
}
