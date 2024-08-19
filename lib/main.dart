import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:tamil_glossary/database/dbhelper.dart';
import 'package:tamil_glossary/model/db_model.dart';
import 'package:tamil_glossary/utils/colors.dart';
import 'routes/pages.dart';
import 'routes/routes.dart';
import 'package:get_storage/get_storage.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  try{
     await GetStorage.init();
WidgetsFlutterBinding.ensureInitialized();
    
      final Directory? downloadsDir = await getApplicationDocumentsDirectory();
      print("download dir ---> $downloadsDir");
      Hive
        ..init(downloadsDir!.path)
        ..registerAdapter(WordsModelAdapter());

      await Hive.openBox<SaveWordsModel>('savedWords');
 
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: AppColors.appbarcolor,
    statusBarBrightness: Brightness.dark,
  ));
 
  _initializeApp();
  }catch(error,stack){
    print("$error---> $stack");
  }
  runApp(const MyApp());
}

void _initializeApp() async {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false;
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.home,
      getPages: AppPages.pages,
      builder: EasyLoading.init(),
    );
  }
}
