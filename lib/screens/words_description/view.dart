import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:tamil_glossary/screens/favorite/controller.dart';
import 'package:tamil_glossary/screens/words_description/controller.dart';

class wordsview extends StatelessWidget {
  final word = Get.put(WordsController());
  final fav = Get.put(FavoriteController());
  wordsview({
    Key? key,
  }) : super(key: key);

  emptywordadd() async {
    debugPrint("Empty word added");
    await word.savewords(Get.arguments.title.toString().obs,
        Get.arguments.snippet.toString().obs);
    await fav.getwords();
    word.emptyword.value = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 5, right: 5),
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: Colors.greenAccent,
              ),
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 20, left: 10, right: 10, bottom: 5),
                    child: Container(
                      child: Text(
                        Get.arguments.title.toString(),
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Container(
                      child: Html(data: Get.arguments.snippet, style: {
                        "body": Style(
                          fontSize: FontSize(15.0),
                          fontWeight: FontWeight.bold,
                        ),
                      }),
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        emptywordadd();
                      },
                      icon: Icon(Icons.favorite)),
                ],
              ),
            ),
          ),
        ),
        IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios_new_sharp)),
      ],
    ));
  }
}
