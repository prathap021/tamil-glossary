import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../API/words_api.dart';
import '../../model/words_model.dart';

class HomeController extends GetxController {
  final scrollController = ScrollController().obs;
  final formKey = GlobalKey<FormState>().obs;
  final wordcontroller = TextEditingController().obs;
  Rx<Remoteservices> fetchdata = Remoteservices().obs;
  RxBool isloading = false.obs;
  RxBool loader = false.obs;
  RxBool isLoading = false.obs;
  RxInt srsoffset = 0.obs;
  RxList<Tamilwords> findedwords = <Tamilwords>[].obs;

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
    await fetchdata.value
        .findwords(wordcontroller.value.text.trim().toString(),
            srsoffset.value.toString())
        .then((value) {
      findedwords.addAll(value!);
      debugPrint(value.length.toString());
      isloading.value = true;
    });
  }
}
