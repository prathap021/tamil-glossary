// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import 'package:tamil_glossary/screens/favorite/controller.dart';
import 'package:tamil_glossary/utils/colors.dart';

class Favoritewords extends StatefulWidget {
  Favoritewords({Key? key}) : super(key: key);

  @override
  State<Favoritewords> createState() => _FavoritewordsState();
}

class _FavoritewordsState extends State<Favoritewords> {
  final favoritecontroller = Get.put(FavoriteController());
  @override
  void initState() {
    print("fav init working");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: AppColors.appbarcolor,
              actions: [
                IconButton(
                    onPressed: () async {
                      await favoritecontroller.deleteallwords();
                    },
                    icon: Icon(Icons.delete))
              ],
              title: Text("Favorite words"),
            ),
            body: Obx(() => favoritecontroller.isloaing.value
                ? ListView.builder(
                    itemCount: favoritecontroller.wordsdb.length,
                    itemBuilder: ((context, index) {
                      return ListTile(
                        trailing: IconButton(
                            onPressed: () async {
                              await favoritecontroller.delete(
                                  favoritecontroller.wordsdb[index].title
                                      .toString()
                                      .obs,
                                  index.obs);
                            },
                            icon: Icon(Icons.delete)),
                        title: Text(favoritecontroller.wordsdb
                            .toSet()
                            .toList()[index]
                            .title
                            .toString()),
                      );
                    }),
                  )
                : Center(child: Text("Favorite is Empty")))));
  }
}
