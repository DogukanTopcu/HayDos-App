import 'package:flutter/material.dart';
import 'package:haydos_app/components/feedingZone.dart';
import 'package:haydos_app/mongodb/DbFeedingModel.dart';
import 'package:haydos_app/mongodb/mongodb.dart';
import 'package:haydos_app/providers/userProvider.dart';
import 'package:provider/provider.dart';

class VolunteerPage extends StatefulWidget {
  const VolunteerPage({super.key});

  @override
  State<VolunteerPage> createState() => _VolunteerPageState();
}

class _VolunteerPageState extends State<VolunteerPage> {
  List<int> selectedLocationIndex = [];
  bool isSelected = false;
  int type = -1;
  List<FeedingModel> feeds = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xffeaffce),
          toolbarHeight: 80,
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Volunteer",
                style: TextStyle(fontSize: 18),
              ),
              Image(
                  image: AssetImage("lib/assets/Haydos_App_Logo.png"),
                  height: 80),
            ],
          ),
        ),
        body: Container(
          padding: const EdgeInsets.only(bottom: 40),
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xffeaffce), Color(0xfffffca1)])),
          child: Center(
            child: SizedBox(
              width: 400,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    width: 400,
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: const Text(
                      "Select Location",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: FutureBuilder(
                      future: MongoDatabase.getAllFeedings(),
                      builder: (context, AsyncSnapshot snapshot) {
                        feeds = [];
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          if (snapshot.hasData) {
                            return ListView.builder(
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, index) {
                                // var feed = snapshot.data[index];
                                FeedingModel feeding =
                                    FeedingModel.fromJson(snapshot.data[index]);
                                feeds.add(feeding);
                                if (feeding.status == "not done") {
                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        if (!selectedLocationIndex
                                            .contains(index)) {
                                          selectedLocationIndex.add(index);
                                        } else {
                                          selectedLocationIndex.remove(index);
                                        }
                                      });
                                    },
                                    child: FeedingZoneWithSelection(
                                      index: index,
                                      name: feeding.name,
                                      status: feeding.status,
                                      selectedIndexList: selectedLocationIndex,
                                    ),
                                  );
                                } else {
                                  return const SizedBox();
                                }
                              },
                            );
                          } else {
                            return const Center(
                              child: Text("No Data Available"),
                            );
                          }
                        }
                      },
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    width: 400,
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: const Text(
                      "Select Carry Method",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              type = 1;
                            });
                          },
                          child: Container(
                            width:
                                MediaQuery.of(context).size.width * 2 / 5 < 150
                                    ? MediaQuery.of(context).size.width * 2 / 5
                                    : 150,
                            height:
                                MediaQuery.of(context).size.width * 2 / 5 < 150
                                    ? MediaQuery.of(context).size.width * 2 / 5
                                    : 150,
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: type == 1 ? 8 : 3,
                                color: type == 1 ? Colors.green : Colors.black,
                              ),
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.amberAccent,
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.drive_eta,
                                size: 64,
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              type = 2;
                            });
                          },
                          child: Container(
                            width:
                                MediaQuery.of(context).size.width * 2 / 5 < 150
                                    ? MediaQuery.of(context).size.width * 2 / 5
                                    : 150,
                            height:
                                MediaQuery.of(context).size.width * 2 / 5 < 150
                                    ? MediaQuery.of(context).size.width * 2 / 5
                                    : 150,
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: type == 2 ? 8 : 3,
                                color: type == 2 ? Colors.green : Colors.black,
                              ),
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.amberAccent,
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.directions_walk,
                                size: 64,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 4 / 5,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all(
                            const EdgeInsets.symmetric(vertical: 20)),
                        backgroundColor: MaterialStateColor.resolveWith(
                            (states) => Colors.green),
                      ),
                      onPressed: selectedLocationIndex.isNotEmpty
                          ? type != -1
                              ? () async {
                                  await Provider.of<UserProvider>(context,
                                          listen: false)
                                      .volunteering(context,
                                          selectedLocationIndex, feeds, type);
                                }
                              : null
                          : null,
                      child: const Text(
                        "Volunteer",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
