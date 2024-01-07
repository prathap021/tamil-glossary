import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:tamil_glossary/utils/constants.dart';
import 'package:tamil_glossary/utils/network_constants.dart';
import '../model/words_model.dart';
import '../widgets/commonwidgets.dart';
import 'apiServices.dart';

class Remoteservices {
  final ApiService _apiService = ApiService();
  final ResponseWidget _responseWidget = ResponseWidget();

  Future<List<Tamilwords>?> findWords(String word, String page) async {
    Map<String, String> payload = {
      NetworkConstants.action: AppConstants.query,
      NetworkConstants.format: AppConstants.json,
      NetworkConstants.list: AppConstants.search,
      NetworkConstants.sroffset: page,
      NetworkConstants.srsearch: word,
    };
    Response response = await _apiService.get(NetworkConstants.baseUrl,
        queryParameters: payload);
    if (response.data != null) {
      if (response.statusCode == 200) {
        return responsedata(response);
      } else if (response.statusCode == 204) {
        _responseWidget.showToast("No Data");
        return responsedata(response);
      } else {
        _responseWidget.showToast("Server Error");
        return responsedata(response);
      }
    } else {
      _responseWidget.showToast("Try Again");
      throw Exception("failed to load data");
    }
  }

  responsedata(Response response) {
    dynamic jsondata = jsonEncode(response.data["query"]["search"]);
    return tamilwordsFromJson(jsondata);
  }
}
