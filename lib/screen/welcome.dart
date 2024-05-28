import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:haydos_app/providers/userProvider.dart';
import 'package:haydos_app/screen/home.dart';
import 'package:haydos_app/screen/login.dart';
import 'package:haydos_app/screen/register.dart';
import 'package:haydos_app/screen/vets.dart';
import 'package:provider/provider.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xff75ae5e), Color(0xffbec459)])),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(),
              const Image(
                  image: AssetImage("lib/assets/Haydos_App_Logo_white.png")),
              Column(
                children: [
                  ElevatedButton(
                      onPressed: Provider.of<UserProvider>(context).isUserExist
                          ? () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const HomePage()));
                            }
                          : () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Login()));
                            },
                      child: const Text("LOG IN")),
                  const SizedBox(height: 10),
                  const Text("It would be ‘paw’some to have you join us"),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignUp()));
                      },
                      child: const Text("SIGN UP")),
                  const SizedBox(height: 30),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const CallVets()));
                      },
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("CALL VETS"),
                          SizedBox(width: 10),
                          Icon(Icons.call),
                        ],
                      )),
                ],
              ),
              Container(
                height: 85,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Image(
                      image: AssetImage("lib/assets/yazilim_logo.png"),
                      width: 85,
                      height: 85,
                    ),
                    const Image(
                      image: AssetImage("lib/assets/iyte_logo_eng.png"),
                      width: 85,
                      height: 85,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: const Image(
                        image: AssetImage("lib/assets/logo.png"),
                        width: 73,
                        height: 73,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
