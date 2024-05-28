import 'package:flutter/material.dart';
import 'package:haydos_app/components/homeButtons.dart';
import 'package:haydos_app/providers/userProvider.dart';
import 'package:haydos_app/screen/adoption.dart';
import 'package:haydos_app/screen/feeding.dart';
import 'package:haydos_app/screen/missing.dart';
import 'package:haydos_app/screen/paws.dart';
import 'package:haydos_app/screen/profile.dart';
import 'package:haydos_app/screen/volunteering.dart';
import 'package:provider/provider.dart';

import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    _launchURL() async {
      final Uri url =
          Uri.parse('https://www.mamakumbarasi.com/iyte-hayvan-dostlari');
      if (!await launchUrl(url)) {
        throw Exception('Could not launch');
      }
    }

    return Scaffold(
        appBar: AppBar(
            backgroundColor: const Color(0xffeaffce),
            // backgroundColor: const Color(0xff75ae5e),
            toolbarHeight: 100,
            title: const Center(
              child: Image(image: AssetImage("lib/assets/Haydos_App_Logo.png")),
            )),
        body: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xffeaffce), Color(0xfffffca1)])),
          // colors: [Color(0xff75ae5e), Color(0xffbec459)])),
          child: Center(
            child: SizedBox(
              width: 400,
              child: Column(
                children: [
                  // Container(
                  //   margin: const EdgeInsets.symmetric(vertical: 10),
                  //   height: 200,
                  //   decoration: BoxDecoration(
                  //     color: Colors.amber,
                  //     borderRadius: BorderRadius.circular(12),
                  //   ),
                  //   child: const Center(
                  //     child: Text("data"),
                  //   ),
                  // ),
                  Expanded(
                    child: GridView(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      ),
                      children: <Widget>[
                        Center(
                          child: Center(
                            child: Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(7),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      gradient: const LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [
                                            Color(0xffd9d9d9),
                                            Color(0xffd9d9d9),
                                          ])),
                                  child: IconButton(
                                      iconSize: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  4 <
                                              150
                                          ? MediaQuery.of(context).size.width /
                                              4
                                          : 150,
                                      onPressed: () {
                                        _launchURL();
                                      },
                                      icon: const Icon(Icons.wallet)),
                                ),
                                const Text("Donate"),
                              ],
                            ),
                          ),
                        ),
                        const Center(
                          child: HomeButton(
                              buttonName: "Paws",
                              route: Paws(),
                              icon: Icon(Icons.pets)),
                        ),
                        Center(
                          child: HomeButton(
                              buttonName: "Feeding & Express",
                              route: Provider.of<UserProvider>(context).isOnDuty
                                  ? const VolunteeringPage()
                                  : const FeedingPage(),
                              icon: const Icon(Icons.food_bank)),
                        ),
                        const Center(
                          child: HomeButton(
                              buttonName: "Adoption",
                              route: AdoptionPage(),
                              icon: Icon(Icons.home)),
                        ),
                        const Center(
                          child: HomeButton(
                              buttonName: "Missing",
                              route: MissingsPage(),
                              icon: Icon(Icons.search)),
                        ),
                        const Center(
                          child: HomeButton(
                              buttonName: "Profile",
                              route: ProfilePage(),
                              icon: Icon(Icons.person)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
