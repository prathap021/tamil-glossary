// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:tamil_glossary/model/words_model.dart';

import 'package:tamil_glossary/services/words_api.dart';
import 'package:flutter_html/flutter_html.dart';

class MyHome extends StatefulWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  final wordcontroller = TextEditingController();
  Remoteservices fetchdata = Remoteservices();
  bool isloading = false;
  List<Tamilwords>? findedwords = [];
  void findwords() {
    fetchdata.findwords(wordcontroller.text.trim().toString()).then((value) {
      setState(() {
        findedwords!.addAll(value!);
        debugPrint(value.length.toString());
        isloading = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Get.isDarkMode
                    ? Get.changeTheme(ThemeData.light())
                    : Get.changeTheme(ThemeData.dark());
              },
              icon: Icon(Icons.lightbulb)),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 5.0),
              child: PopupMenuButton(
                child: Icon(Icons.more_vert),
                itemBuilder: (context) => [
                  PopupMenuItem(
                      child: GestureDetector(
                    child: Center(child: Text('About')),
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Center(
                                  child: Text(
                                "",
                                style: TextStyle(
                                    fontSize: 15, color: Colors.black),
                              )),
                            );
                          });
                    },
                  )),
                ],
              ),
            )
          ],
          title: Text('தமிழ் சொற்களஞ்சியம் '),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 100, left: 30, right: 30),
                child: TextField(
                    controller: wordcontroller,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search),
                        hintText: 'தமிழில் உள்ளீடு செய்யவும் ',
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(30))))),
              ),
              Padding(
                padding: EdgeInsets.all(25),
                child: ElevatedButton(
                  onPressed: () {
                    findwords();
                  },
                  child: Text('தேடு'),
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15))),
                ),
              ),
              SizedBox(
                  height: 350,
                  width: double.infinity,
                  child: isloading
                      ? ListView.builder(
                          itemCount: findedwords!.length,
                          itemBuilder: ((context, index) {
                            return Card(
                                child: ListTile(
                              title: Html(data: findedwords![index].title),
                            ));
                          }))
                      : Center(
                          child: CircularProgressIndicator(
                            color: Colors.indigo,
                          ),
                        ))
            ],
          ),
        ));
  }
}
