import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import 'package:tamil_glossary/database/dbhelper.dart';
import 'package:tamil_glossary/model/db_model.dart';
import 'package:tamil_glossary/model/words_model.dart';
import 'package:tamil_glossary/model/wordsdb_model.dart';

class FavoriteController extends GetxController {
  Dbhelper _dbhelper=Dbhelper();
  final favWords = <SaveWordsModel>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
   if( _dbhelper.getAllWords().isNotEmpty){
    favWords.addAll(_dbhelper.getAllWords());
    print("your fav words count is ---> ${favWords.length}");
  
    }
   }
  //  favWords.value=_dbhelper.getAllWords();
    // favWords.addAll(_)
  }
// }
