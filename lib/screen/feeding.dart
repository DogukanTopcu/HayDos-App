import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:haydos_app/components/feedingZone.dart';
import 'package:haydos_app/mongodb/DbFeedingModel.dart';
import 'package:haydos_app/mongodb/mongodb.dart';
import 'package:haydos_app/providers/feedingProvider.dart';
import 'package:haydos_app/screen/volunteer.dart';
import 'package:provider/provider.dart';

class FeedingPage extends StatefulWidget {
  const FeedingPage({super.key});

  @override
  State<FeedingPage> createState() => _FeedingPageState();
}

class _FeedingPageState extends State<FeedingPage> {
  @override
  void initState() {
    super.initState();
    Provider.of<FeedingProvider>(context, listen: false).refreshFeedings();
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
            Text(
              "Feeding & Express",
              style: TextStyle(fontSize: 18),
            ),
            Image(
                image: AssetImage("lib/assets/Haydos_App_Logo.png"),
                height: 80),
          ],
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 40),
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
                const Text(
                  "Feeding Zones: ",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Expanded(
                  child: FutureBuilder(
                    future: MongoDatabase.getAllFeedings(),
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
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
                              return FeedingZone(
                                name: feeding.name,
                                status: feeding.status,
                                location: feeding.location,
                              );
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
                  margin: const EdgeInsets.only(top: 10),
                  width: MediaQuery.of(context).size.width * 4 / 5,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all(
                            const EdgeInsets.symmetric(vertical: 20)),
                        backgroundColor: MaterialStateColor.resolveWith(
                            (states) => Colors.red)),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const VolunteerPage()));
                    },
                    child: const Text(
                      "Be Volunteer",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
