import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:haydos_app/components/feedingZone.dart';
import 'package:haydos_app/mongodb/mongodb.dart';
import 'package:haydos_app/providers/userProvider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class VolunteeringPage extends StatefulWidget {
  const VolunteeringPage({super.key});

  @override
  State<VolunteeringPage> createState() => _VolunteeringPageState();
}

class _VolunteeringPageState extends State<VolunteeringPage> {
  int selectedIndex = -1;

  Map<String, dynamic> feedings = {};
  Map<String, dynamic> expresses = {};

  List<dynamic> feeds = [];
  List<dynamic> express = [];

  int numberOfItem = 0;

  @override
  Widget build(BuildContext context) {
    Future<List<Map<String, dynamic>>> _futureData =
        MongoDatabase.getExpressByUserId(Provider.of<UserProvider>(context).id);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffeaffce),
        toolbarHeight: 80,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Good Work!"),
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
          colors: [Color(0xffeaffce), Color(0xfffffca1)],
        )),
        child: Center(
          child: Container(
            width: 400,
            margin: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: FutureBuilder(
                    future: _futureData,
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        numberOfItem = snapshot.data.length;
                        return ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            var express = snapshot.data[index];
                            // expresses = [];
                            // if (!expresses.contains(snapshot.data[index])) {
                            //   print(snapshot.data[index]["_id"]);
                            //   expresses.add(snapshot.data[index]);
                            // }
                            return FutureBuilder(
                              future: MongoDatabase.getFeedingById(
                                  snapshot.data[index]["feedingId"]),
                              builder: (context, AsyncSnapshot snapshot) {
                                if (snapshot.hasData) {
                                  // feedings = [];
                                  // if (!feedings.contains(snapshot.data)) {
                                  //   feedings.add(snapshot.data);
                                  // }
                                  return Column(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            if (selectedIndex != index) {
                                              selectedIndex = index;
                                              feedings = snapshot.data;
                                              expresses = express;
                                            } else {
                                              selectedIndex = -1;
                                              feedings = {};
                                              expresses = {};
                                            }
                                          });
                                        },
                                        child: FeedingZoneWithOneSelection(
                                          index: index,
                                          name: snapshot.data["name"],
                                          status: snapshot.data["status"],
                                          selectedIndex: selectedIndex,
                                        ),
                                      ),
                                      Container(
                                        width: 150,
                                        padding: const EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 19, 92, 151),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        child: GestureDetector(
                                          onTap: () async {
                                            final Uri url = Uri.parse(
                                                snapshot.data["location"]);
                                            if (!await launchUrl(url)) {
                                              throw Exception(
                                                  'Could not launch');
                                            }
                                          },
                                          child: const Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Go to location",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Icon(
                                                Icons.add_location_outlined,
                                                size: 16,
                                                color: Colors.white,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                } else {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                              },
                            );
                          },
                        );
                      }
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 3 / 7 < 190
                          ? MediaQuery.of(context).size.width * 3 / 7
                          : 190,
                      height: 48,
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateColor.resolveWith(
                                (states) =>
                                    const Color.fromARGB(255, 26, 209, 32))),
                        onPressed: selectedIndex != -1
                            ? () async {
                                await Provider.of<UserProvider>(context,
                                        listen: false)
                                    .pressCompleted(
                                  context,
                                  feedings,
                                  expresses,
                                  numberOfItem,
                                );
                                setState(() {
                                  _futureData =
                                      MongoDatabase.getExpressByUserId(
                                          Provider.of<UserProvider>(context,
                                                  listen: false)
                                              .id);
                                  selectedIndex = -1;
                                  feedings = {};
                                  expresses = {};
                                });
                              }
                            : null,
                        child: const Text(
                          "Completed",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 3 / 7 < 190
                          ? MediaQuery.of(context).size.width * 3 / 7
                          : 190,
                      height: 48,
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateColor.resolveWith(
                                (states) => Colors.red)),
                        onPressed: selectedIndex != -1
                            ? () async {
                                await Provider.of<UserProvider>(context,
                                        listen: false)
                                    .pressCancel(
                                  context,
                                  feedings,
                                  expresses,
                                  numberOfItem,
                                );
                                setState(() {
                                  _futureData =
                                      MongoDatabase.getExpressByUserId(
                                          Provider.of<UserProvider>(context,
                                                  listen: false)
                                              .id);
                                  selectedIndex = -1;
                                  feedings = {};
                                  expresses = {};
                                });
                              }
                            : null,
                        child: const Text(
                          "Cancel",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
