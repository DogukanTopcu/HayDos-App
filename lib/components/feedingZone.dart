import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

class FeedingZone extends StatelessWidget {
  final String name;
  final String status;
  final String location;
  const FeedingZone(
      {super.key,
      required this.name,
      required this.status,
      required this.location});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      padding: const EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width * 4 / 5,
      decoration: BoxDecoration(
          color: switch (status) {
            "done" => Colors.lightGreen,
            "proceed" => Colors.amberAccent,
            "not done" => Colors.lightBlue,
            String() => throw UnimplementedError(),
          },
          borderRadius: BorderRadius.circular(10)),
      child: Center(
          child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                name,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              Container(
                width: 60,
                decoration: BoxDecoration(
                    color: switch (status) {
                      "done" => Colors.green,
                      "proceed" => Colors.amber,
                      "not done" => const Color.fromARGB(255, 197, 84, 76),
                      String() => throw UnimplementedError(),
                    },
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(width: 1, color: Colors.black)),
                child: Center(
                  child: Text(
                    status,
                    style: const TextStyle(fontSize: 12, color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: 95,
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 19, 92, 151),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: GestureDetector(
                  onTap: () async {
                    final Uri url = Uri.parse(location);
                    if (!await launchUrl(url)) {
                      throw Exception('Could not launch');
                    }
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Location",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w500),
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
          )
        ],
      )),
    );
  }
}

class FeedingZoneWithSelection extends StatelessWidget {
  final int index;
  final String name;
  final String status;
  final List<int> selectedIndexList;
  const FeedingZoneWithSelection(
      {super.key,
      required this.index,
      required this.name,
      required this.status,
      required this.selectedIndexList});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      padding: const EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width * 4 / 5,
      decoration: BoxDecoration(
        color: switch (status) {
          "done" => Colors.lightGreen,
          "proceed" => Colors.amberAccent,
          "not done" => Colors.lightBlue,
          String() => throw UnimplementedError(),
        },
        borderRadius: BorderRadius.circular(10),
        border: selectedIndexList.contains(index)
            ? Border.all(
                width: 3,
                color: Colors.black,
              )
            : null,
      ),
      child: Center(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            name,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          Container(
            width: 60,
            decoration: BoxDecoration(
                color: switch (status) {
                  "done" => Colors.green,
                  "proceed" => Colors.amber,
                  "not done" => const Color.fromARGB(255, 197, 84, 76),
                  String() => throw UnimplementedError(),
                },
                borderRadius: BorderRadius.circular(5),
                border: Border.all(width: 1, color: Colors.black)),
            child: Center(
              child: Text(
                status,
                style: const TextStyle(fontSize: 12, color: Colors.black),
              ),
            ),
          ),
        ],
      )),
    );
  }
}

class FeedingZoneWithOneSelection extends StatelessWidget {
  final int index;
  final String name;
  final String status;
  final int selectedIndex;
  const FeedingZoneWithOneSelection(
      {super.key,
      required this.index,
      required this.name,
      required this.status,
      required this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      padding: const EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width * 4 / 5,
      decoration: BoxDecoration(
        color: switch (status) {
          "done" => Colors.lightGreen,
          "proceed" => Colors.amberAccent,
          "not done" => Colors.lightBlue,
          String() => throw UnimplementedError(),
        },
        borderRadius: BorderRadius.circular(10),
        border: selectedIndex == index
            ? Border.all(
                width: 3,
                color: Colors.black,
              )
            : null,
      ),
      child: Center(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            name,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          Container(
            width: 60,
            decoration: BoxDecoration(
                color: switch (status) {
                  "done" => Colors.green,
                  "proceed" => Colors.amber,
                  "not done" => const Color.fromARGB(255, 197, 84, 76),
                  String() => throw UnimplementedError(),
                },
                borderRadius: BorderRadius.circular(5),
                border: Border.all(width: 1, color: Colors.black)),
            child: Center(
              child: Text(
                status,
                style: const TextStyle(fontSize: 12, color: Colors.black),
              ),
            ),
          ),
        ],
      )),
    );
  }
}
