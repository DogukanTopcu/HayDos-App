import 'package:flutter/material.dart';
import 'package:haydos_app/models/userModel.dart';
import 'package:haydos_app/providers/userProvider.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _obscurePassword = true;
  User user =
      User(name: "", email: "", password: "", phoneNumber: "", isOnDuty: false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffeaffce),
        toolbarHeight: 80,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Login"),
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
            constraints: const BoxConstraints(maxWidth: 450),
            padding: const EdgeInsets.all(20),
            child: Form(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    onChanged: (value) {
                      user.email = value;
                    },
                    style: const TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white, // Inside color
                      prefixIcon: const Icon(Icons.mail),
                      hintText: "Your Mail",
                      contentPadding: const EdgeInsets.all(10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                            color: Colors.black, width: 1), // Border color
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    obscureText: _obscurePassword,
                    onChanged: (value) {
                      user.password = value;
                    },
                    style: const TextStyle(color: Colors.black), // Text color
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white, // Inside color
                      prefixIcon: const Icon(Icons.lock),
                      hintText: "Your Password",
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                      contentPadding: const EdgeInsets.all(10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                            color: Colors.black, width: 1), // Border color
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  ElevatedButton(
                      onPressed: () {
                        if (user.email.isNotEmpty && user.password.isNotEmpty) {
                          Provider.of<UserProvider>(context, listen: false)
                              .login(user, context);
                        }
                      },
                      child: const Text("LOG IN")),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
