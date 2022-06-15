// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: MyHome(),
    );
  }
}

class MyHome extends StatefulWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  final _input = TextEditingController();
  bool sw = false;

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
                    controller: _input,
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
                  onPressed: () {},
                  child: Text('தேடு'),
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15))),
                ),
              ),
            ],
          ),
        ));
  }
}
