import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import 'package:tamil_glossary/database/dbhelper.dart';
import 'package:tamil_glossary/model/db_model.dart';
import 'package:tamil_glossary/model/wordsdb_model.dart';
import 'package:tamil_glossary/screens/favorite/favourite_controller.dart';

class WordsController extends GetxController {
  Dbhelper _dbhelper=Dbhelper();


  void saveWords(SaveWordsModel data)async{
   if(!await _dbhelper.isWordExist(data.title)){
    _dbhelper.setWords(data);
   }else{
    print("words already saved");
   }
}



  
  
  

  @override
  void onInit() async {
    super.onInit();
   
  }

  
}
