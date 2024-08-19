import 'dart:async';
import 'dart:collection';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:tamil_glossary/database/dbhelper.dart';
import 'package:tamil_glossary/model/login_model.dart';
import 'package:tamil_glossary/model/wordsdb_model.dart';
import 'package:tamil_glossary/routes/pages.dart';

class SplashController extends GetxController {
  final getbox = GetStorage();
  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Timer(Duration(seconds: 1), () {
        final data = getbox.read("userDetails");
        if (data != null) {
          Get.toNamed(AppRoutes.home);
        } else {
          Get.toNamed(AppRoutes.login);
        }
      });
    });
  }
}
