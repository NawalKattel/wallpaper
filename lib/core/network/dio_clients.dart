import 'package:dio/dio.dart';

import 'package:wallpaper_app/core/constants/api_key.dart';
import 'package:wallpaper_app/core/constants/api_url.dart';

class DioClients {
  final Dio _dio;

  DioClients(this._dio) {
    _dio.options = BaseOptions(
      baseUrl: APIUrl.baseURl,
      connectTimeout: Duration(seconds: 10),
      receiveTimeout: Duration(seconds: 10),

      headers: {
        'Authorization': ApiKey.apiKey,
        'Content-Type': 'application/json',
      },
    );

    _dio.interceptors.add(
      LogInterceptor(
        request: true,
        responseBody: true,
        requestHeader: false,
        responseHeader: false,
        error: true,
      ),
    );
  }

  Future<Response> get(
    String path, {
    Map<String, dynamic>? params,
    Options? options,
  }) async {
    try {
      final response = await _dio.get(path, queryParameters: params);

      return response;
    } on DioException catch (e) {
    
      print('GET DioException occurred : ${e.message}');
      rethrow;
    }
  }

  Future<Response> post(
    String path, {
    Map<String, dynamic>? params,
    dynamic data,
    Options? options,
  }) async {
    try {
      return await _dio.post(
        path,
        queryParameters: params,
        data: data,
        options: options,
      );
    } on DioException catch (e) {
         print('POST DioException occurred : ${e.message}');
    
      rethrow;
    }
  }
}
