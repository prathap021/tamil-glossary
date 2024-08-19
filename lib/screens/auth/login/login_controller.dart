// import 'dart:async';
// import 'dart:convert';
// import 'dart:developer';
//
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
//
// //import 'package:rounded_loading_button/rounded_loading_button.dart';
//
// // import 'package:rounded_loading_button/rounded_loading_button.dart';
// import 'package:tamil_glossary/API/apiServices.dart';
// import 'package:tamil_glossary/API/auth-Apis.dart';
// import 'package:tamil_glossary/model/auth_model.dart';
// import 'package:tamil_glossary/model/login_model.dart';
// import 'package:tamil_glossary/routes/pages.dart';
// import 'package:tamil_glossary/utils/constants.dart';
// import 'package:tamil_glossary/widgets/commonwidgets.dart';
//
// import '../../../utils/network_constants.dart';
// import 'package:http/http.dart' as http;
//
// class LoginController extends GetxController {
//   LoginController({required this.context});
//   late BuildContext context;
//   Map<String, String> cookieheaders = {};
//
//   final userNamecontroller = TextEditingController().obs;
//   final passwordController = TextEditingController().obs;
//   final authservices = Authservices();
//   final ApiService _apiService = ApiService();
//   final getbox = GetStorage();
//   final ResponseWidget _responseWidget = ResponseWidget();
//   // final btnController = RoundedLoadingButtonController().obs;
//
//   void fetchToken() async {
//     await GetStorage().remove("logCookies"); //remove stored cookie
//     Tokens? tokens = await authservices.gettoken(AppConstants.login);
//
//     if (tokens != null) {
//       LoginModel? loginmodel = await login(tokens.logintoken,
//           userNamecontroller.value.text, passwordController.value.text);
//
//       if (loginmodel != null) {
//         // print(loginmodel.reason);
//         if (loginmodel.result == "Success") {
//           print(jsonEncode(loginmodel));
//           getbox.write("userDetails", jsonEncode(loginmodel));
//           Get.toNamed(AppRoutes.home);
//         } else {
//           Get.snackbar('', '',
//               titleText: Text(
//                 loginmodel.result!,
//                 style: TextStyle(color: Colors.orange),
//               ),
//               messageText: Text(
//                 loginmodel.reason!,
//                 style: TextStyle(color: Colors.black54),
//               ),
//               margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
//               padding: EdgeInsets.all(10),
//               snackPosition: SnackPosition.TOP);
//         }
//       }
//       // btnController.value.success();
//     }
//   }
//
//   Future<LoginModel?> login(
//       String? token, String? userName, String? password) async {
//     Map<String, String> payload = {
//       NetworkConstants.action: AppConstants.login,
//       NetworkConstants.lgname: userName!,
//       NetworkConstants.lgpassword: password!,
//       NetworkConstants.lgtoken: token!,
//       NetworkConstants.format: AppConstants.json,
//     };
//     final loginResult = await _apiService.post(
//       NetworkConstants.baseUrl,
//       data: _apiService.bodyForm(payload),
//     );
//
//     if (loginResult.statusCode == 200) {
//       final jsondata = jsonEncode(loginResult.data["login"]);
//
//       return LoginModel.fromJson(jsonDecode(jsondata));
//     } else {
//       _responseWidget.showToast("Server Error");
//       throw Exception("Server Error");
//     }
//   }
// }
