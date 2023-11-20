import 'package:dio/dio.dart';

import '../exceptions/exceptions.dart';

extension Handle on DioException {
  Exception handle([String key = 'error']) {
    try {
      if (response != null) {
        return ServerException(message: response!.data[key]);
      } else {
        return ServerException(message: error.toString());
      }
    } catch (e) {
      return UnknownException(message: e.toString());
    }
  }
}

class DioHelper {
  /// My Dio Client...
  late Dio _client;

  /// Constructor to init client data...
  DioHelper() {
    _client = Dio(
      BaseOptions(
        baseUrl: '',
        receiveDataWhenStatusError: true,
        receiveTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 10),
        headers: {
          'Content-Type': 'application/json',
        },
      ),
    );
  }

  Future<Response> postData(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool withToken = false,
    String? token,
  }) async =>
      await _client.post(
        path,
        queryParameters: queryParameters,
        data: data,
        options: Options(
          contentType: 'application/json',
          headers: {'Content-Type': 'application/json', if (withToken) "Authorization": "Bearer $token"},
        ),
      );

  Future<Response> getData(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool withToken = false,
    String? token,
  }) async =>
      await _client.get(
        path,
        queryParameters: queryParameters,
        data: data,
        options: Options(
          contentType: 'application/json',
          headers: {'Content-Type': 'application/json', if (withToken) "Authorization": "Bearer $token"},
        ),
      );

  Future<Response> patchData(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool withToken = false,
    String? token,
  }) async =>
      await _client.patch(
        path,
        queryParameters: queryParameters,
        data: data,
        options: Options(
          contentType: 'application/json',
          headers: {'Content-Type': 'application/json', if (withToken) "Authorization": "Bearer $token"},
        ),
      );

  Future<Response> deleteData(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool withToken = false,
    String? token,
  }) async =>
      await _client.delete(
        path,
        queryParameters: queryParameters,
        data: data,
        options: Options(
          contentType: 'application/json',
          headers: {'Content-Type': 'application/json', if (withToken) "Authorization": "Bearer $token"},
        ),
      );
}
