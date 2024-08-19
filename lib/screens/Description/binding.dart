import 'package:get/get.dart';

import 'controller.dart';

class WordsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WordsController());
  }
}
