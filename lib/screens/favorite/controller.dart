import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import 'package:tamil_glossary/database/dbhelper.dart';
import 'package:tamil_glossary/model/wordsdb_model.dart';

class FavoriteController extends GetxController {
  Rx<DBProvider> dbProvider = DBProvider.db.obs;
  RxList<WordsDb> wordsdb = <WordsDb>[].obs;
  RxBool isloaing = false.obs;
  @override
  void onInit() {
    super.onInit();
    getwords();
  }

  //fetch all words from db
  getwords() async {
    await dbProvider.value.getAllWords().then((res) {
      update();
      wordsdb.addAll(res);
      debugPrint(res.length.toString());

      if (wordsdb.isNotEmpty) {
        isloaing.value = true;
      }
    });
  }

  //delete db all words
  deleteallwords() async {
    await dbProvider.value.deleteAllWords();
    isloaing.value = false;
  }

  //delet perticular title only
  delete(RxString title, RxInt index) async {
    await dbProvider.value.delete(title.value);
    wordsdb.removeAt(index.value);
  }
}
