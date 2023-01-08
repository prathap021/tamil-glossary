// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:tamil_glossary/model/words_model.dart';
import 'package:tamil_glossary/screens/favorite_words.dart';

import 'package:tamil_glossary/services/words_api.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:tamil_glossary/screens/words_details.dart';

class MyHome extends StatefulWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  final formKey = GlobalKey<FormState>();
  final wordcontroller = TextEditingController();
  Remoteservices fetchdata = Remoteservices();
  bool isloading = false;
  bool loader = false;
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
  void dispose() {
    wordcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text(
              'தமிழ் சொற்களஞ்சியம்',
              style: TextStyle(fontSize: 15),
            ),
            centerTitle: true,
            actions: [
              IconButton(
                  onPressed: () {
                    Get.isDarkMode
                        ? Get.changeTheme(ThemeData.light())
                        : Get.changeTheme(ThemeData.dark());
                  },
                  icon: Icon(Icons.lightbulb)),
              IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Favoritewords()));
                  },
                  icon: Icon(Icons.history))
            ],
          ),
          body: SafeArea(
            child: Column(
              children: [
                Form(
                  key: formKey,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 20),
                    child: Center(
                      child: TextFormField(
                          style: TextStyle(fontSize: 12),
                          controller: wordcontroller,
                          onChanged: (v) {
                            setState(() {
                              if (v.isNotEmpty) {
                                loader = true;
                              } else {
                                loader = false;
                              }
                            });
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'பொருளுக்கான வார்த்தையை உள்ளிடவும் ';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              hintText: 'தமிழில் உள்ளீடு செய்யவும் ',
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(17))))),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                IconButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        setState(() {
                          isloading = false;
                          findedwords?.clear();
                        });
                        findwords();
                      }
                    },
                    icon: Icon(
                      Icons.search,
                      size: 30,
                    )),
                Text(
                  isloading
                      ? "முடிவுகள்:\t" + findedwords!.length.toString()
                      : "",
                  textAlign: TextAlign.end,
                ),
                Expanded(
                  child: isloading
                      ? ListView.builder(
                          itemCount: findedwords!.length,
                          itemBuilder: ((context, index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              child: Card(
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                      color: Colors.greenAccent,
                                    ),
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  child: ListTile(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) {
                                          return WordsDetails(
                                            findedwords: findedwords![index],
                                          );
                                        }),
                                      );
                                    },
                                    title:
                                        Html(data: findedwords![index].title),
                                  )),
                            );
                          }))
                      : Center(
                          child: Visibility(
                            visible: loader,
                            child: CircularProgressIndicator(
                              color: Colors.indigo,
                            ),
                          ),
                        ),
                )
              ],
            ),
          )),
    );
  }
}
