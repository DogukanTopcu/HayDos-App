import 'package:flutter/material.dart';
import 'package:haydos_app/models/userModel.dart';
import 'package:haydos_app/providers/userProvider.dart';
import 'package:provider/provider.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool _obscurePassword = true;
  User user =
      User(name: "", email: "", password: "", phoneNumber: "", isOnDuty: false);

  bool phoneController = true;
  bool nameController = true;
  bool mailController = true;
  bool passwordController = true;

  bool checkPhoneNumber(String phoneNumber) {
    if (phoneNumber.split("")[0] == "+") {
      if (phoneNumber.length != 13) {
        return false;
      }
      String result = "";
      for (String i in phoneNumber.split("").getRange(2, 13)) {
        result += i;
      }
      user.phoneNumber = result;
      return true;
    } else if (phoneNumber.split("")[0] == "9") {
      if (phoneNumber.length != 12) {
        return false;
      }
      String result = "";
      for (String i in phoneNumber.split("").getRange(1, 12)) {
        result += i;
      }
      user.phoneNumber = result;
      return true;
    } else if (phoneNumber.split("")[0] == "0") {
      if (phoneNumber.length != 11) {
        return false;
      }
      return true;
    } else {
      if (phoneNumber.length != 10) {
        return false;
      }
      user.phoneNumber = "0$phoneNumber";
      return true;
    }
  }

  bool checkFullName(String name) {
    if (name.split(" ").length >= 2) {
      user.name = name.toLowerCase();
      return true;
    }
    return false;
  }

  bool checkEmail(String email) {
    if (email.contains("@")) {
      if (email.split("@")[1] == "std.iyte.edu.tr" ||
          email.split("@")[1] == "iyte.edu.tr") {
        return true;
      }
      return false;
    }
    return false;
  }

  bool checkPassword(String password) {
    if (password.length > 5) {
      return true;
    }
    return false;
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
            Text("Sign Up"),
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
                      user.phoneNumber = value;
                    },
                    style: const TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white, // Inside color
                      prefixIcon: const Icon(Icons.phone),
                      hintText: "Phone Number",
                      contentPadding: const EdgeInsets.all(10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                            color: Colors.black, width: 1), // Border color
                      ),
                    ),
                  ),
                  Text(
                    !phoneController ? "Invalid phone number" : "",
                    style: const TextStyle(color: Colors.red, fontSize: 12),
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    onChanged: (value) {
                      user.name = value;
                    },
                    style: const TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white, // Inside color
                      prefixIcon: const Icon(Icons.person_4),
                      hintText: "Your Name & Surname",
                      contentPadding: const EdgeInsets.all(10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                            color: Colors.black, width: 1), // Border color
                      ),
                    ),
                  ),
                  Text(
                    !nameController ? "Invalid name & surname" : "",
                    style: const TextStyle(color: Colors.red, fontSize: 12),
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    onChanged: (value) {
                      user.email = value;
                    },
                    style: const TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white, // Inside color
                      prefixIcon: const Icon(Icons.mail),
                      hintText: "Your Iyte Mail",
                      contentPadding: const EdgeInsets.all(10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                            color: Colors.black, width: 1), // Border color
                      ),
                    ),
                  ),
                  Text(
                    !mailController ? "Invalid email address" : "",
                    style: const TextStyle(color: Colors.red, fontSize: 12),
                  ),
                  const SizedBox(height: 15),
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
                  Text(
                    !passwordController
                        ? "Invalid password. Password length must be greater than 5"
                        : "",
                    style: const TextStyle(color: Colors.red, fontSize: 12),
                  ),
                  const SizedBox(height: 40),
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          phoneController = checkPhoneNumber(user.phoneNumber);
                          nameController = checkFullName(user.name);
                          mailController = checkEmail(user.email);
                          passwordController = checkPassword(user.password);
                        });

                        if (phoneController &&
                            nameController &&
                            mailController &&
                            passwordController) {
                          Provider.of<UserProvider>(context, listen: false)
                              .register(user, context);
                        }

                        // Navigator.pop(context);
                        // Navigator.pop(context);
                      },
                      child: const Text("SIGN UP")),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _sendMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Operation failed."),
      ),
    );
  }
}
