import 'package:flutter/material.dart';
import 'package:haydos_app/providers/userProvider.dart';
import 'package:haydos_app/screen/welcome.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    String email = Provider.of<UserProvider>(context).email;
    String name = Provider.of<UserProvider>(context).name;
    String phoneNumber = Provider.of<UserProvider>(context).phoneNumber;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffeaffce),
        toolbarHeight: 80,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Profile"),
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
            alignment: Alignment.topCenter,
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 40),
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  Container(
                    width: MediaQuery.of(context).size.width * 2 / 3 < 250
                        ? MediaQuery.of(context).size.width * 2 / 3
                        : 250,
                    height: MediaQuery.of(context).size.width * 2 / 3 < 250
                        ? MediaQuery.of(context).size.width * 2 / 3
                        : 250,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Color(0xff75ae5e), Color(0xffbec459)]),
                      border:
                          Border.all(color: const Color(0xffc6e997), width: 10),
                      borderRadius: BorderRadius.circular(125),
                    ),
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    child: const Icon(
                      Icons.person,
                      size: 140,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 30),
                    child: const Column(
                      children: [
                        Text(
                          "Score:",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "0",
                          style: TextStyle(fontSize: 32),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 30),
                    child: Column(
                      children: [
                        const Text(
                          "Full Name:",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(name),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 30),
                    child: Column(
                      children: [
                        const Text(
                          "Mail:",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(email),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 30),
                    child: Column(
                      children: [
                        const Text(
                          "Phone Number:",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text("+9$phoneNumber"),
                      ],
                    ),
                  ),
                  const SizedBox(height: 50),
                  ElevatedButton(
                      onPressed: () {
                        Provider.of<UserProvider>(context, listen: false)
                            .logout();
                        Navigator.pop(context);
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => const WelcomePage()));
                      },
                      child: const Text("LOG OUT"))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
