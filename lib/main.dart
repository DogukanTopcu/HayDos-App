import 'package:flutter/material.dart';
import 'package:haydos_app/mongodb/mongodb.dart';
import 'package:haydos_app/providers/feedingProvider.dart';
import 'package:haydos_app/providers/petProvider.dart';
import 'package:haydos_app/providers/userProvider.dart';
import 'package:haydos_app/screen/welcome.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MongoDatabase.connect();
  runApp(ChangeNotifierProvider<PetProvider>(
      create: (BuildContext context) => PetProvider(),
      child: ChangeNotifierProvider<UserProvider>(
        create: (BuildContext context) => UserProvider(),
        child: ChangeNotifierProvider<FeedingProvider>(
          create: (BuildContext context) => FeedingProvider(),
          child: const MainApp(),
        ),
      )));
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  void initState() {
    super.initState();
    // Provider.of<FeedingProvider>(context, listen: false).listAllFeedings();
    Provider.of<PetProvider>(context, listen: false).listAllPets();
    Provider.of<UserProvider>(context, listen: false).loginAutomatically();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Haydos',
      theme: ThemeData(
        brightness: Brightness.light, // Koyu tema
        primarySwatch: Colors.blue,
      ),
      home: const WelcomePage(),
    );
  }
}
