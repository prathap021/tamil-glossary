import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/rendering.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tamil_glossary/utils/network_constants.dart';

class ApiService {
  final _dio = Dio();
  final getbox = GetStorage();

  ApiService() {
    // getbox.remove("logCookies");
    _dio.options = BaseOptions(
      baseUrl: NetworkConstants.baseUrl,
      connectTimeout: Duration(minutes: 1),
      receiveTimeout: Duration(minutes: 1),
      responseType: ResponseType.json,
    );
    _dio.interceptors.clear();
    _dio.interceptors.add(
      LogInterceptor(
        request : true,
        requestHeader :true,
        requestBody : false,
        responseHeader : true,
        responseBody : false,
        error : true,
      )
    //     QueuedInterceptorsWrapper(
    //   onRequest: (options, handler) async {
    //     options.headers['cookie'] = await getbox.read("logCookies");
    //     return handler.next(options);
    //   },
    //   onResponse: (response, handler) {
    //     var box = GetStorage();
    //     response.headers.forEach((name, values) async {
    //       if (name == HttpHeaders.setCookieHeader) {
    //         final cookieMap = <String, String>{};
    //
    //         for (var c in values) {
    //           var key = '';
    //           var value = '';
    //
    //           key = c.substring(0, c.indexOf('='));
    //           value = c.substring(key.length + 1, c.indexOf(';'));
    //
    //           cookieMap[key] = value;
    //         }
    //
    //         var cookiesFormatted = '';
    //
    //         cookieMap
    //             .forEach((key, value) => cookiesFormatted += '$key=$value; ');
    //
    //         getbox.write("logCookies", cookiesFormatted);
    //         return;
    //       }
    //     });
    //
    //     return handler.next(response);
    //   },
    // )
    );
  }

  bodyForm(dynamic form) {
    return FormData.fromMap(form);
  }

  // GET request
  Future<Response> get(
    String? url, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.get(
        url!,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // POST request
  Future<Response> post(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.post(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // // PUT request
  // Future<Response> put(
  //   String url, {
  //   dynamic data,
  //   Map<String, dynamic>? queryParameters,
  //   Options? options,
  //   CancelToken? cancelToken,
  //   ProgressCallback? onSendProgress,
  //   ProgressCallback? onReceiveProgress,
  // }) async {
  //   try {
  //     final Response response = await _dio.put(
  //       url,
  //       data: data,
  //       queryParameters: queryParameters,
  //       options: options,
  //       cancelToken: cancelToken,
  //       onSendProgress: onSendProgress,
  //       onReceiveProgress: onReceiveProgress,
  //     );
  //     return response;
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  // // DELETE request
  // Future<Response> delete(
  //   String url, {
  //   dynamic data,
  //   Map<String, dynamic>? queryParameters,
  //   Options? options,
  //   CancelToken? cancelToken,
  //   ProgressCallback? onSendProgress,
  //   ProgressCallback? onReceiveProgress,
  // }) async {
  //   try {
  //     final Response response = await _dio.delete(
  //       url,
  //       data: data,
  //       queryParameters: queryParameters,
  //       options: options,
  //       cancelToken: cancelToken,
  //     );
  //     return response;
  //   } catch (e) {
  //     rethrow;
  //   }
  // }
}
