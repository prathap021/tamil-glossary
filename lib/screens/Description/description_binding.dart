import 'package:get/get.dart';

import 'description_controller.dart';

class WordsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WordsController());
  }
}
