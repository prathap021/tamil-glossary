import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:tamil_glossary/model/db_model.dart';
import 'package:tamil_glossary/model/words_model.dart';
import 'package:tamil_glossary/screens/Description/description_controller.dart';
import 'package:tamil_glossary/utils/colors.dart';
import 'package:tamil_glossary/widgets/commonwidgets.dart';

class DescriptionView extends StatelessWidget {
  final descCtrl=Get.put(WordsController());
  Tamilwords descriptions = Get.arguments;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(250),
        child: AppBar(
          toolbarHeight: 50,
          title: Text(
            "Description",
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: Colors.white),
          ),
          flexibleSpace: Padding(
            padding: EdgeInsets.only(top: 70),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  descriptions.title ?? "",
                  textAlign: TextAlign.center,
                  maxLines: 3,
                  style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                        onPressed: () {
                          Clipboard.setData(ClipboardData(text: "${descriptions.title ?? ""}"));
                          ResponseWidget().showToast("Text copied ");
                        },
                        icon: Container(
                          decoration: BoxDecoration(
                              color: Colors.white10,
                              borderRadius: BorderRadius.circular(12)),
                          padding: EdgeInsets.all(10),
                          child: Icon(Icons.copy, color: Colors.white),
                        )),
                    IconButton(
                        onPressed: () {
                        descCtrl.saveWords(SaveWordsModel(
                          id:'',
                          title: descriptions.title??"",
                          body: descriptions.snippet??"", 
                        ));
                        },
                        icon: Container(
                          decoration: BoxDecoration(
                              color: Colors.white10,
                              borderRadius: BorderRadius.circular(12)),
                          padding: EdgeInsets.all(10),
                          child: Icon(Icons.bookmark_add_outlined,
                              color: Colors.white),
                        )),
                    IconButton(
                        onPressed: () {},
                        icon: Container(
                          decoration: BoxDecoration(
                              color: Colors.white10,
                              borderRadius: BorderRadius.circular(12)),
                          padding: EdgeInsets.all(10),
                          child: Icon(Icons.share, color: Colors.white),
                        )),
                    IconButton(
                        onPressed: () {},
                        icon: Container(
                          decoration: BoxDecoration(
                              color: Colors.white10,
                              borderRadius: BorderRadius.circular(12)),
                          padding: EdgeInsets.all(10),
                          child: Icon(Icons.speaker, color: Colors.white),
                        )),

                    // Container(
                    //   decoration: BoxDecoration(
                    //       color: Colors.white10,
                    //       borderRadius: BorderRadius.circular(12)),
                    //   padding: EdgeInsets.all(10),
                    //   child: Icon(Icons.copy, color: Colors.white),
                    // )
                  ],
                )
              ],
            ),
          ),
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              )),
          backgroundColor: AppColors.appbarcolor,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 20, top: 20, right: 20, bottom: 20),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Defination - ta",
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: AppColors.appbarcolor,
                      fontWeight: FontWeight.bold),
                ),
                IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {},
                    icon: Icon(
                      Icons.copy,
                      color: AppColors.appbarcolor,
                    ))
              ],
            ),
            SizedBox(
              height: 15,
            ),
            HtmlWidget(
              descriptions.snippet ?? "",
              renderMode: RenderMode.column,
              textStyle: Theme.of(context).textTheme.titleSmall,
            ),
          ],
        ),
      ),
    );
  }
}
