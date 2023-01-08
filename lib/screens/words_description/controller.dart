import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import 'package:tamil_glossary/database/dbhelper.dart';
import 'package:tamil_glossary/model/wordsdb_model.dart';

class WordsController extends GetxController {
  Rx<DBProvider> dbProvider = DBProvider.db.obs;
  Rx<WordsDb> wordsdb = WordsDb().obs;
  RxList swl = [].obs;
  RxBool wordis = false.obs;
  RxBool emptyword = false.obs;

  savewords(RxString title, RxString descone) async {
    wordsdb.value.title = title.value;
    wordsdb.value.description = descone.value;

    var res = await dbProvider.value.savewords(wordsdb.value);
    debugPrint(res.toString());
  }
}
