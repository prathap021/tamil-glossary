import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:tamil_glossary/routes/pages.dart';
import 'package:tamil_glossary/widgets/commonwidgets.dart';

import '../../API/words_api.dart';
import '../../model/words_model.dart';

class HomeController extends GetxController {
  final scrollController = ScrollController().obs;
  final formKey = GlobalKey<FormState>().obs;
  final wordcontroller = TextEditingController().obs;
  Rx<Remoteservices> fetchdata = Remoteservices().obs;
  final ResponseWidget _responseWidget = ResponseWidget();
  RxBool isloading = false.obs;
  RxBool loader = false.obs;
  RxBool isLoading = false.obs;
  RxInt srsoffset = 0.obs;
  RxInt selectedindex = 0.obs;

  // RxInt onItemTapped = 0.obs;
  RxList<Tamilwords> findedwords = <Tamilwords>[].obs;
  PersistentTabController? controller;

  @override
  void onInit() {
    super.onInit();

    findedwords.value.clear();
    scrollController.value.addListener(() {
      if (scrollController.value.position.maxScrollExtent ==
          scrollController.value.position.pixels) {
        if (!isLoading.value) {
          isLoading.value = !isLoading.value;
          srsoffset.value = srsoffset.value + 10;
          fetchwords();
          isLoading.value = !isLoading.value;
        }
      }
    });
  }

  @override
  void dispose() {
    wordcontroller.value.dispose();

    super.dispose();
  }

  void fetchwords() async {
    bool result = await InternetConnectionChecker().hasConnection;
    if (result) {
      await fetchdata.value
          .findWords(wordcontroller.value.text.trim().toString(),
              srsoffset.value.toString())
          .then((value) {
        findedwords.addAll(value!);
        debugPrint(value.length.toString());
        isloading.value = true;
      });
    } else {
      print("No internet");
      _responseWidget.showToast("Check Your Internet Connection");
    }
  }

  void onItemTapped(int index) {
    selectedindex.value = index;
    Get.deleteAll();
    update();
  }
}
