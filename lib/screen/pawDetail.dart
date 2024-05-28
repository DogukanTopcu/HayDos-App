import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:haydos_app/models/petModel.dart';

class PawDetail extends StatefulWidget {
  final Pet pet;
  const PawDetail({super.key, required this.pet});

  @override
  State<PawDetail> createState() => _PawDetailState();
}

class _PawDetailState extends State<PawDetail> {
  final TextEditingController _textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    String gender = widget.pet.getGender();
    int age = widget.pet.getAge();
    String healthCondition = widget.pet.getHealthCondition();
    String funfact = widget.pet.getFunfact();

    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xffeaffce),
          toolbarHeight: 80,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.pet.getName()),
              const Image(
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
                margin: const EdgeInsets.only(top: 40),
                alignment: Alignment.topCenter,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 2 / 3 < 250
                            ? MediaQuery.of(context).size.width * 2 / 3
                            : 250,
                        height: MediaQuery.of(context).size.width * 2 / 3 < 250
                            ? MediaQuery.of(context).size.width * 2 / 3
                            : 250,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: const Color(0xffc6e997), width: 10),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(40),
                          child: Image(
                            image: AssetImage(widget.pet.getImage()),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 30),
                        child: Column(
                          children: [
                            const Text(
                              "Gender:",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Text(gender),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 30),
                        child: Column(
                          children: [
                            const Text(
                              "Age:",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Text(age.toString()),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 30),
                        child: Column(
                          children: [
                            const Text(
                              "Health Condition:",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              healthCondition,
                              style: TextStyle(height: 3),
                            ),
                            FilledButton(
                                style: const ButtonStyle(
                                    backgroundColor: MaterialStatePropertyAll(
                                        Color(0xff33571E))),
                                onPressed: () {
                                  _openPanel();
                                },
                                child: const Text(
                                  "Report",
                                  style: TextStyle(color: Color(0xffF2FFB7)),
                                )),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 30),
                        child: Column(
                          children: [
                            const Text(
                              "Fun Fact:",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Text(funfact),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )));
  }

  void _openPanel() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _textEditingController,
                decoration: const InputDecoration(labelText: 'Yeni Metin'),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      // if (_textEditingController.text.isEmpty) {
                      //   _showsnackbar("The file name cannot be blank");
                      // } else {
                      //   Provider.of<EditorProvider>(context, listen: false)
                      //       .changeDocumentName(_textEditingController.text);
                      // }
                    },
                    child: const Text('Onayla'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('İptal Et'),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
