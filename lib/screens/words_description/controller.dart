import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import 'package:tamil_glossary/database/dbhelper.dart';
import 'package:tamil_glossary/model/wordsdb_model.dart';
import 'package:tamil_glossary/screens/favorite/controller.dart';

class WordsController extends GetxController {
  final fav = Get.put(FavoriteController());
  Rx<DBProvider> dbProvider = DBProvider.db.obs;
  Rx<WordsDb> wordsdb = WordsDb().obs;
  RxList swl = [].obs;
  RxBool wordis = false.obs;
  RxBool emptyword = false.obs;
  RxBool iswordexsist = false.obs;

  savewords(RxString title, RxString descone) async {
    final data = await fav.dbProvider.value.query(Get.arguments.title);
    if (!data) {
      wordsdb.value.title = title.value;
      wordsdb.value.description = descone.value;

      var res = await dbProvider.value.savewords(wordsdb.value);
      debugPrint(res.toString());
    } else {}
    iswordexsist.value = await fav.dbProvider.value.query(Get.arguments.title);

    // wordsdb.value.title = title.value;
    // wordsdb.value.description = descone.value;

    // var res = await dbProvider.value.savewords(wordsdb.value);
    // debugPrint(res.toString());
  }

  @override
  void onInit() async {
    super.onInit();
    iswordexsist.value = await fav.dbProvider.value.query(Get.arguments.title);
  }

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

}
