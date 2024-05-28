import 'package:flutter/material.dart';
import 'package:haydos_app/components/pawButton.dart';
import 'package:haydos_app/models/petModel.dart';
import 'package:haydos_app/providers/petProvider.dart';
import 'package:provider/provider.dart';

class Paws extends StatefulWidget {
  const Paws({super.key});

  @override
  State<Paws> createState() => _PawsState();
}

class _PawsState extends State<Paws> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffeaffce),
        toolbarHeight: 80,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Paws"),
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
                  crossAxisCount: 2,
                ),
                itemCount: Provider.of<PetProvider>(context, listen: false)
                    .pets
                    .length,
                itemBuilder: (context, index) {
                  Pet pet = Provider.of<PetProvider>(context).pets[index];
                  return Center(
                    child: PawButton(
                      pet: pet,
                    ),
                  );
                }),
          ),
        ),
      ),
    );
  }
}
