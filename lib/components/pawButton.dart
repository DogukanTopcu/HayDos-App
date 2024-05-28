import 'package:flutter/material.dart';
import 'package:haydos_app/models/petModel.dart';
import 'package:haydos_app/screen/pawDetail.dart';

class PawButton extends StatelessWidget {
  final Pet pet;

  const PawButton({super.key, required this.pet});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PawDetail(
                            pet: pet,
                          )));
            },
            child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 5),
                  borderRadius: BorderRadius.circular(15),
                ),
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image(
                    image: AssetImage(pet.getImage()),
                    fit: BoxFit.cover,
                  ),
                )),
          ),
          Text(pet.getName()),
        ],
      ),
    );
  }
}
