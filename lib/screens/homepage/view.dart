// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:get/get.dart';
import 'package:tamil_glossary/screens/words_description/view.dart';

import '../favorite/view.dart';
import 'controller.dart';

class Homeview extends StatelessWidget {
  final home = Get.put(HomeController());
  Homeview({Key? key}) : super(key: key);

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
                Get.to(() => Favoritewords());
              },
              icon: Icon(Icons.history))
        ],
      ),
      body: Obx(() => Column(
            children: [
              Form(
                key: home.formKey.value,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: Center(
                    child: TextFormField(
                        style: TextStyle(fontSize: 12),
                        controller: home.wordcontroller.value,
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
                    if (home.formKey.value.currentState!.validate()) {
                      home.isloading.value = false;
                      home.findedwords.clear();
                      home.fetchwords();
                    }
                  },
                  icon: Icon(
                    Icons.search,
                    size: 30,
                  )),
              Text(
                home.isloading.value
                    ? "முடிவுகள்:\t" + home.findedwords.length.toString()
                    : "",
                textAlign: TextAlign.end,
              ),
              Expanded(
                child: home.isloading.value
                    ? ListView.builder(
                        controller: home.scrollController.value,
                        itemCount: home.findedwords.length + 1,
                        itemBuilder: ((context, index) {
                          if (index == home.findedwords.length) {
                            return Padding(
                              padding: const EdgeInsets.all(10),
                              child: SpinKitThreeBounce(
                                color: Colors.green,
                                size: 15.0,
                                //xcontroller: AnimationController(vsync: this, duration: const Duration(milliseconds: 1200)),
                              ),
                            );
                          } else {
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
                                      Get.to(() => wordsview(),
                                          arguments: home.findedwords[index]);
                                    },
                                    title: Html(
                                        data: home.findedwords[index].title),
                                  )),
                            );
                          }
                        }))
                    : Center(
                        child: Visibility(
                          visible: home.loader.value,
                          child: CircularProgressIndicator(
                            color: Colors.indigo,
                          ),
                        ),
                      ),
              )
            ],
          )),
    ));
  }
}
