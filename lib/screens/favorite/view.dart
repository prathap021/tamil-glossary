// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import 'package:tamil_glossary/screens/favorite/controller.dart';

class Favoritewords extends StatelessWidget {
  Favoritewords({Key? key}) : super(key: key);

  final favoritecontroller = Get.put(FavoriteController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
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
