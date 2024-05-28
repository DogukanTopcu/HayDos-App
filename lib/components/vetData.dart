import 'package:flutter/material.dart';

class VetData extends StatelessWidget {
  final String vetName;
  final double rate;
  final String phoneNumber;
  final String location;

  const VetData(
      {super.key,
      required this.vetName,
      required this.rate,
      required this.phoneNumber,
      required this.location});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xff75ae5e), Color(0xffbec459)]),
        border: Border.all(color: const Color(0xffc6e997), width: 10),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                vetName,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    "$rate/5",
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Icon(
                Icons.phone,
                size: 32,
              ),
              const SizedBox(width: 10),
              Text(
                phoneNumber,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Icon(
                Icons.location_on,
                size: 32,
              ),
              const SizedBox(width: 10),
              Text(
                location,
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
