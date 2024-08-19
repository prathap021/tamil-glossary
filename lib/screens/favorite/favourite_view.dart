// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:tamil_glossary/screens/favorite/favourite_controller.dart';


class Favoritewords extends StatelessWidget {
  Favoritewords({Key? key}) : super(key: key);

  final favCtrl = Get.put(FavoriteController());

  @override
  Widget build(BuildContext context) {
  return SafeArea(child: Scaffold(
    appBar: AppBar(
      title: Text("Favourite"),
    ),
    body: ListView.builder(
      
      itemCount: favCtrl.favWords.length,
      itemBuilder: (context,index){
      return ListTile(
        
        leading: Text("${index+1}"),
        title: Text(favCtrl.favWords.elementAt(index).title),


      );
    }),
  ));
  }
}
