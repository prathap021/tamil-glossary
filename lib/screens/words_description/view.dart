import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';
import 'package:tamil_glossary/screens/favorite/controller.dart';
import 'package:tamil_glossary/screens/words_description/controller.dart';

class wordsview extends StatelessWidget {
  final word = Get.put(WordsController());
  var arguments = Get.arguments;
  // final fav = Get.put(FavoriteController());
  wordsview({
    Key? key,
  }) : super(key: key);

  // savedata() async {
  //   debugPrint("Empty word added");
  //   print(Get.arguments.title);
  //   final data = await fav.dbProvider.value.query(Get.arguments.title);
  //   if (!data) {
  //     await word.savewords(Get.arguments.title.toString().obs,
  //         Get.arguments.snippet.toString().obs);
  //   }
  //   // await word.savewords(Get.arguments.title.toString().obs,
  //   //     Get.arguments.snippet.toString().obs);
  // }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
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
                        child: Text(
                          Get.arguments.title.toString(),
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
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
                      LikeButton(
                        isLiked: word.iswordexsist.value,
                        onTap: (v) async {
                          await word.savewords(
                              Get.arguments.title.toString().obs,
                              Get.arguments.snippet.toString().obs);
                        },
                        size: 20,
                        circleColor: CircleColor(
                            start: Color(0xff00ddff), end: Color(0xff0099cc)),
                        bubblesColor: BubblesColor(
                          dotPrimaryColor: Color(0xff33b5e5),
                          dotSecondaryColor: Color(0xff0099cc),
                        ),
                      ),
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
        )));
  }
}
