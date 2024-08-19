import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'package:tamil_glossary/API/apiServices.dart';
import 'package:tamil_glossary/database/dbhelper.dart';
import 'package:tamil_glossary/model/db_model.dart';
import 'package:tamil_glossary/screens/favorite/favourite_controller.dart';

import 'package:tamil_glossary/utils/constants.dart';
import 'package:tamil_glossary/utils/debouncer.dart';
import 'package:tamil_glossary/utils/network_constants.dart';
import 'package:tamil_glossary/widgets/commonwidgets.dart';

import '../../model/words_model.dart';

class HomeController extends GetxController {
  final focusNode = FocusNode();

  final formKey = GlobalKey<FormState>().obs;
  final wordcontroller = TextEditingController().obs;
  final ApiService _apiService = ApiService();
  final ResponseWidget _responseWidget = ResponseWidget();
  final deBouncer = Debouncer(milliseconds: 1000);
  final Dbhelper dbhelper=Dbhelper();
 

  final selectedIndex = 0.obs;
  final findedwords = <Tamilwords>[].obs;

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    deBouncer.dispose();
  }

  @override
  void onInit() {
    super.onInit();

  }

  

  @override
  void dispose() {
    wordcontroller.value.dispose();

    super.dispose();
  }

  void getWords(String query) async {
    await findWords(query, '1').then((result) async{
      if (result != null) {
        findedwords.clear();
        for(var dicwords in result){
          findedwords.add(Tamilwords(
           title: dicwords.title??"",
           snippet: dicwords.snippet??"",
           selected: await dbhelper.isWordExist(dicwords.title??"")
           
          ));
        }
      
      } else {
        print("result is ---> $result");
      }
    });
  }

   void saveWords(String title,String body)async{
   if(!await dbhelper.isWordExist(title)){
    dbhelper.setWords(SaveWordsModel(id: '',title: title,body: body));
   }else{
    dbhelper.removeWords(title);
    print("words already saved");
   }
   getWords(wordcontroller.value.text);
   }

  void onItemTapped(int index) {
    selectedIndex.value= index;
    Get.delete<FavoriteController>();
    
  
  }



  Future<List<Tamilwords>?> findWords(String word, String page) async {
    List<Tamilwords>? tamilWords = [];
    try {
      if (await InternetConnectionChecker().hasConnection) {
        EasyLoading.show();
        Map<String, String> payload = {
          NetworkConstants.action: AppConstants.query,
          NetworkConstants.format: AppConstants.json,
          NetworkConstants.list: AppConstants.search,
          NetworkConstants.sroffset: page,
          NetworkConstants.srsearch: word,
        };
        final response = await _apiService.get(NetworkConstants.baseUrl,
            queryParameters: payload);
        if (response.statusCode == 200) {
          EasyLoading.dismiss();
          print(response.data);

          dynamic jsonData = jsonEncode(response.data["query"]["search"]);
          print("your search query result is ---> $jsonData");
          tamilWords = tamilwordsFromJson(jsonData);
        } else {
          throw Exception(response.statusCode);
        }
      } else {
        EasyLoading.dismiss();
        _responseWidget.showToast("please check your connectivity");
      }
    } catch (e, s) {
      EasyLoading.dismiss();
      _responseWidget.showToast("Something went wrong");

      print("$e,$s");
    }
    return tamilWords;
  }
}
