import 'package:flutter/material.dart';

class HomeButton extends StatelessWidget {
  final String buttonName;
  final StatefulWidget route;
  final Icon icon;

  const HomeButton(
      {super.key,
      required this.buttonName,
      required this.route,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(7),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: const Color(0xffd9d9d9)),
            child: IconButton(
                iconSize: MediaQuery.of(context).size.width / 4 < 150
                    ? MediaQuery.of(context).size.width / 4
                    : 150,
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => route));
                },
                icon: icon),
          ),
          Text(buttonName),
        ],
      ),
    );
  }
}
