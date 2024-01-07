import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tamil_glossary/routes/pages.dart';
import 'package:tamil_glossary/screens/setting/controller.dart';

import '../../utils/colors.dart';

class Setting extends StatelessWidget {
  Setting({Key? key}) : super(key: key);
  final fav = Get.put(SettingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: AppColors.appbarcolor,
          actions: [],
          title: Text("Setting")),
      body: Center(
        child: InkWell(
            onTap: () {
              GetStorage().remove("userDetails");
              Get.toNamed(AppRoutes.login);
            },
            child: Text("Logout")),
      ),
    );
  }
}
