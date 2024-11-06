import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class BaseDio {
  Future<Dio> getBaseDio() async {
    BaseOptions options = BaseOptions(
      baseUrl: "https://newsapi.org",
      connectTimeout: const Duration(seconds: 30),
      responseType: ResponseType.json,
    );

    Dio dio = Dio(options);

    dio.interceptors.add(LogInterceptor(
      request: kDebugMode,
      requestBody: kDebugMode,
      requestHeader: kDebugMode,
      responseBody: kDebugMode,
      responseHeader: kDebugMode,
      error: kDebugMode,
    ));
    return dio;
  }
}
