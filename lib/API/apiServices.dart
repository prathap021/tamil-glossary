import 'package:dio/dio.dart';
import 'package:tamil_glossary/utils/network_constants.dart';

class ApiService {
  static final _options = BaseOptions(
    baseUrl: NetworkConstants.baseUrl,
    connectTimeout: NetworkConstants.connectionTimeout,
    receiveTimeout: NetworkConstants.receiveTimeout,
    responseType: ResponseType.json,
  );

  final Dio _dio = Dio(_options)..interceptors.add(LogInterceptor());

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

  // // POST request
  // Future<Response> post(
  //   String url, {
  //   dynamic data,
  //   Map<String, dynamic>? queryParameters,
  //   Options? options,
  //   CancelToken? cancelToken,
  //   ProgressCallback? onSendProgress,
  //   ProgressCallback? onReceiveProgress,
  // }) async {
  //   try {
  //     final Response response = await _dio.post(
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
