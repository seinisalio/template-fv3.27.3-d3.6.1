// coverage:ignore-file
import 'package:dio/dio.dart';

import 'api_mock_resolver/auth/mock_login.dart';

/// Simple API Mock interceptor
/// Only for demo purposes
class MockInterceptor extends Interceptor {

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
