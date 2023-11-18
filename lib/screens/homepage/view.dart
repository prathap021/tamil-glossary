// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:get/get.dart';
import 'package:tamil_glossary/routes/pages.dart';
import 'package:tamil_glossary/routes/routes.dart';
import 'package:tamil_glossary/screens/setting/view.dart';
import 'package:tamil_glossary/screens/words_description/view.dart';

import '../favorite/view.dart';
import 'controller.dart';

class Homeview extends StatelessWidget {
  final home = Get.put(HomeController());
  Homeview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => SafeArea(
          child: Scaffold(
              backgroundColor: Colors.grey.shade100,
              // appBar: AppBar(
              //   title: Text(
              //     'தமிழ் சொற்களஞ்சியம்',
              //     style: TextStyle(fontSize: 15),
              //   ),
              //   centerTitle: true,
              //   actions: [
              //     IconButton(
              //         onPressed: () {
              //           Get.isDarkMode
              //               ? Get.changeTheme(ThemeData.light())
              //               : Get.changeTheme(ThemeData.dark());
              //         },
              //         icon: Icon(Icons.lightbulb)),
              //     IconButton(
              //         onPressed: () {
              //           Get.to(() => Favoritewords());
              //         },
              //         icon: Icon(Icons.history))
              //   ],
              // ),
              bottomNavigationBar: BottomNavigationBar(
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.search),
                    label: 'search',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.square_fill_line_vertical_square),
                    label: 'Favourite',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.settings_solid),
                    label: 'Setting',
                  ),
                ],
                currentIndex: home.selectedindex.value,
                selectedItemColor: Colors.amber[800],
                onTap: home.onItemTapped,
              ),
              body: [
                AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    transitionBuilder:
                        (Widget child, Animation<double> animation) {
                      return FadeTransition(child: child, opacity: animation);
                    },
                    child: searchpage()),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  transitionBuilder:
                      (Widget child, Animation<double> animation) {
                    return FadeTransition(child: child, opacity: animation);
                  },
                  child: Favoritewords(),
                ),
                AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    transitionBuilder:
                        (Widget child, Animation<double> animation) {
                      return FadeTransition(child: child, opacity: animation);
                    },
                    child: Setting()),
              ].elementAt(home.selectedindex.value)),
        ));
  }

  Widget searchpage() {
    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: <Widget>[
            Container(
              height: 100,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xff4da0b0), Color(0xff4da0b0)]),
              ),
            ),
            Positioned(
              top: 75,
              left: 20,
              right: 20,
              child: Form(
                key: home.formKey.value,
                child: SizedBox(
                  height: 60,
                  child: TextFormField(
                    style: TextStyle(fontSize: 15),
                    controller: home.wordcontroller.value,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      suffixIcon: InkWell(
                          onTap: () {
                            home.isloading.value = false;
                            home.findedwords.clear();
                            home.fetchwords();
                          },
                          child: Icon(
                            Icons.search,
                            color: Colors.grey,
                            size: 25,
                          )),
                      filled: true,
                      fillColor: Color(0xffE5E4E2),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none),
                      hintText: 'தமிழ் சொற்களஞ்சியம்',
                      isDense: true,
                      contentPadding:
                          EdgeInsets.only(top: 4, bottom: 4, left: 6, right: 6),
                      hintStyle: TextStyle(
                        color: Colors.black54,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
        SizedBox(
          height: 50,
        ),
        Text(
          home.isloading.value
              ? "முடிவுகள்:\t" + home.findedwords.length.toString()
              : "",
          textAlign: TextAlign.end,
        ),
        SizedBox(
          height: 10,
        ),
        Expanded(
          child: home.isloading.value
              ? ListView.builder(
                  controller: home.scrollController.value,
                  itemCount: home.findedwords.length + 1,
                  itemBuilder: ((context, index) {
                    if (index == home.findedwords.length) {
                      if (home.findedwords.length > 7) {
                        return Padding(
                          padding: const EdgeInsets.all(10),
                          child: SpinKitThreeBounce(
                            color: Colors.green,
                            size: 15.0,
                            //xcontroller: AnimationController(vsync: this, duration: const Duration(milliseconds: 1200)),
                          ),
                        );
                      } else {
                        return Text("");
                      }
                    } else {
                      return Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: ListTile(
                          onTap: () {
                            Get.to(() => wordsview(),
                                arguments: home.findedwords[index]);
                          },
                          title: Html(data: home.findedwords[index].title),
                        ),
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
        ),
      ],
    );
  }
}
