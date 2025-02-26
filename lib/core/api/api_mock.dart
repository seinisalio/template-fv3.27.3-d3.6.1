// coverage:ignore-file

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';

import 'api_mock_resolver/auth/mock_login.dart';

/// Simple API Mock interceptor
/// Only for demo purposes
class MockInterceptor extends Interceptor {
  //
  static const _jsonDir = 'assets/json/';

  static const String httpGet = 'GET';
  static const String httpPost = 'POST';
  static const String httpDelete = 'DELETE';
  static const String httpPut = 'PUT';

  Future<dynamic> retrieveData(String resourcePath) async {
    final String data = await rootBundle.loadString(_jsonDir + resourcePath);
    final map = jsonDecode(data);
    return map;
  }

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // Réponse spécifique pour les requêtes /auth
    if (options.path.startsWith('/auth')) {
      return handler.resolve(await AuthMockApi.handler(options));
    }
    // 
    else {
      return handler.resolve(Response(
        statusCode: 404,
        requestOptions: options,
      ));
    }
  }

  
}
