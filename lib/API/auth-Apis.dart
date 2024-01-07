import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive/hive.dart';
import 'package:tamil_glossary/API/apiServices.dart';
import 'package:tamil_glossary/model/auth_model.dart';
import 'package:tamil_glossary/utils/constants.dart';
import 'package:tamil_glossary/utils/network_constants.dart';
import 'package:tamil_glossary/widgets/commonwidgets.dart';

class Authservices {
  final ApiService _apiService = ApiService();
  final ResponseWidget _responseWidget = ResponseWidget();

  Future<Tokens?> gettoken(String tokentype) async {
    Map<String, String> payload = {
      NetworkConstants.action: AppConstants.query,
      NetworkConstants.format: AppConstants.json,
      NetworkConstants.meta: AppConstants.tokens,
      NetworkConstants.formatversion: AppConstants.fv2,
      NetworkConstants.type: tokentype,
    };
    final response = await _apiService.get(
      NetworkConstants.baseUrl,
      queryParameters: payload,
    );

    if (response.data != null) {
      if (response.statusCode == 200) {
        return tokenResponse(response);
      } else {
        _responseWidget.showToast("Server Error");
        throw Exception("Server Error");
      }
    } else {
      _responseWidget.showToast("Try Again");
      throw Exception("failed to load data");
    }
  }

  tokenResponse(Response response) {
    print(response.data);
    dynamic jsondata = jsonEncode(response.data["query"]["tokens"]);
    return Tokens.fromJson(jsonDecode(jsondata));
  }
}
