import 'dart:convert';
import 'package:dio/dio.dart';

import 'package:tamil_glossary/utils/constants.dart';

import '../model/words_model.dart';

class Remoteservices {
  Future<List<Tamilwords>?> findwords(String word, String page) async {
    var dio = Dio();
    var options = Options();
    options.contentType = 'application/json';
    Map<String, String> qParams = {
      'action': 'query',
      'format': 'json',
      'list': 'search',
      "sroffset": page,
      'srsearch': word
    };
    var response = await dio.get(ApiServices.endpoint,
        options: options, queryParameters: qParams);
    print("Url ${ApiServices.endpoint + qParams.toString()}");
    if (response.statusCode == 200) {
      var jsondata = jsonEncode(response.data["query"]["search"]);

      return tamilwordsFromJson(jsondata);
    } else {
      throw Exception("failed to load data");
    }
  }
}
