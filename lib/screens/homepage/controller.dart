import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../API/words_api.dart';
import '../../model/words_model.dart';

class HomeController extends GetxController {
  final formKey = GlobalKey<FormState>().obs;
  final wordcontroller = TextEditingController().obs;
  Rx<Remoteservices> fetchdata = Remoteservices().obs;
  RxBool isloading = false.obs;
  RxBool loader = false.obs;
  RxInt index = 0.obs;
  RxList<Tamilwords> findedwords = <Tamilwords>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void dispose() {
    wordcontroller.value.dispose();
    super.dispose();
  }

  void fetchwords() async {
    await fetchdata.value
        .findwords(wordcontroller.value.text.trim().toString())
        .then((value) {
      findedwords.addAll(value!);
      debugPrint(value.length.toString());
      isloading.value = true;
    });
  }
}
