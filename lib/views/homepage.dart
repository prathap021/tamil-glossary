// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:tamil_glossary/model/words_model.dart';

import 'package:tamil_glossary/services/words_api.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:tamil_glossary/widget/words_details.dart';

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
            title: Text('தமிழ் சொற்களஞ்சியம்'),
            centerTitle: true,
          ),
          body: SafeArea(
            child: Column(
              children: [
                Form(
                  key: formKey,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 20),
                    child: TextFormField(
                        controller: wordcontroller,
                        onChanged: (v) {
                          setState(() {
                            if (v.length >= 1) {
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
                            prefixIcon: Icon(Icons.search),
                            hintText: 'தமிழில் உள்ளீடு செய்யவும் ',
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30))))),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(25),
                  child: ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        setState(() {
                          isloading = false;
                          findedwords?.clear();
                        });
                        findwords();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Processing Data')),
                        );
                      }
                    },
                    child: Text('தேடு'),
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15))),
                  ),
                ),
                Text("முடிவுகள் :" + findedwords!.length.toString()),
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
                                    borderRadius: BorderRadius.circular(
                                        20.0), //<-- SEE HERE
                                  ),
                                  child: ListTile(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => WordsDetails(
                                                  findedwords:
                                                      findedwords![index],
                                                )),
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
