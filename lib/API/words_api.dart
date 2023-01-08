import 'dart:convert';
import 'package:dio/dio.dart';


import 'package:tamil_glossary/utils/constants.dart';

import '../model/words_model.dart';

class Remoteservices {
  Future<List<Tamilwords>?> findwords(String word) async {
    var dio = Dio();
    var options = Options();
    options.contentType = 'application/json';
    Map<String, String> qParams = {
      'action': 'query',
      'format': 'json',
      'list': 'search',
      'srsearch': word
    };
    var response = await dio.get(ApiServices.endpoint,
        options: options, queryParameters: qParams);
    if (response.statusCode == 200) {
      var jsondata = jsonEncode(response.data["query"]["search"]);

      return tamilwordsFromJson(jsondata);
    } else {
      throw Exception("failed to load data");
    }
  }
}
