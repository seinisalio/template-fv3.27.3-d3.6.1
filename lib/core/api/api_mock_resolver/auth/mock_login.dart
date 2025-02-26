
import 'package:dio/dio.dart';

import '../../api_method.dart';
import 'data.dart';

class AuthMockApi{

  static Future<Response> handler (RequestOptions options) async {
    final requestPath = options.path;
    if(options.method == httpPost && requestPath.startsWith('/auth/login')){
      // Accédez au contenu du corps de la requête
      // final requestBody = options.data as Map?;
      // //
      return await Future.delayed(
        const Duration(milliseconds: 1000),
        () => Response(
          data: loginPost,
          statusCode: 200,
          requestOptions: options,
        ),
      );
    }
    else if(options.method == httpPost && requestPath.startsWith('/auth/register')){
      // Accédez au contenu du corps de la requête
      // final requestBody = options.data as Map?;
      // //
      return await Future.delayed(
        const Duration(milliseconds: 1000),
        () => Response(
          data: registerPost,
          statusCode: 200,
          requestOptions: options,
        ),
      );
    }
    return Response(requestOptions: options, statusCode: 404);
  }
}