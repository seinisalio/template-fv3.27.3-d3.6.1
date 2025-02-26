// coverage:ignore-file

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'api_mock.dart';
import '../env.dart';
import '../local_storage/secure_storage.dart';
import '../logger.dart';


/// Core Api Service pour effectuer les appels aux APIs
/// Dio est utilisé pour les appels Http dans le projet.
/// Vous pouvez modifier cette classe pour utiliser un autre client http
/// En gardant la meme signature des méthodes, ce changement sera transparent
/// aux classes qui l'utilisent sur la couche infra
class Api {

  static const _apiUrlKey = 'API_URL';

  static const _modeKey = 'MODE';

  static late Dio client;

  /// Créer le client HTTP
  static Future<void> init() async{

    // Recuperer l'URL de l'API
    String baseUrl = AppEnv.get(_apiUrlKey)??'';
    AppLogger.info("API URL $baseUrl");

    String? mode = AppEnv.get(_modeKey);
    AppLogger.info("MODE $mode");

    // Créer l'instance Dio
    client = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        receiveDataWhenStatusError: true,
        connectTimeout: const Duration(minutes: 1), // 60 seconds
        receiveTimeout: const Duration(minutes: 1), // 60 seconds
      ),
    )
    // Ajouter l'intercepteur pour les erreurs
    ..interceptors.add(ErrorInterceptor());

    // - Ajouter l'intercepteur qui ajoute le token
    // Sinon mocker les APIs en mode démo
    client.interceptors.add((mode == null || mode == 'demo') 
      ? TokenInterceptor(client) : MockInterceptor()
    );

    // L'ordre des intercepteurs compte
    // - Ajouter l'intercepteur pour logger
    if (kDebugMode) client.interceptors.add(LoggingInterceptor());
  }

  /// Effectue un appel GET
  /// En fonction du client Http que vous souhaitez utilisez,
  /// vous pouvez modifier l'implémentation de cette méthode
  static Future<ApiResponse> get(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    String? responseType,
    int? sendTimeout,
    Map<String, dynamic>? extra,
  }) async {
    // Create dio options from params
    Options options = Options(headers: headers, extra: extra);
    if (sendTimeout != null) {
      options.sendTimeout = Duration(milliseconds: sendTimeout);
    }
    // Call the dio client to make the api call
    try {
      final response = await client.get(path,
          data: data, queryParameters: queryParameters, options: options);
      return ApiResponse(response.data, response.statusCode);
    } //
    on DioException catch (e) {
      throw e.error as ApiException;
    }
  }

  static Future<ApiResponse> delete(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    String? responseType,
    int? sendTimeout,
    Map<String, dynamic>? extra,
  }) async {
    // Create dio options from params
    Options options = Options(headers: headers, extra: extra);
    if (sendTimeout != null) {
      options.sendTimeout = Duration(milliseconds: sendTimeout);
    }
    // Call the dio client to make the api call
    try {
      final response = await client.delete(path,
          data: data, queryParameters: queryParameters, options: options);
      return ApiResponse(response.data, response.statusCode);
    } //
    on DioException catch (e) {
      throw e.error as ApiException;
    }
  }

  static Future<ApiResponse<T>> post<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    String? responseType,
    int? sendTimeout,
    Map<String, dynamic>? extra,
  }) async {
    // Create dio options from params
    Options options = Options(headers: headers, extra: extra);
    if (sendTimeout != null) {
      options.sendTimeout = Duration(milliseconds: sendTimeout);
    }

    // Call the dio client to make the POST request
    try {
      final response = await client.post(path,
          data: data, queryParameters: queryParameters, options: options);
      // checkErrors(response);
      return ApiResponse<T>(response.data, response.statusCode);
    } //
    on DioException catch (e) {
      throw e.error as ApiException;
    }
  }

  static Future<ApiResponse<T>> put<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    String? responseType,
    int? sendTimeout,
    Map<String, dynamic>? extra,
  }) async {
    final response = await Api.client.put<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: Options(headers: headers, extra: extra),
    );
    checkErrors(response);
    return ApiResponse<T>(response.data, response.statusCode);
  }

  static void checkErrors(Response response) {
    if (response.statusCode == 400) {
      throw ApiException(
        error: ApiError.badRequest,
        statusCode: response.statusCode,
        statusMessage: response.statusMessage
      );
    } else if (response.statusCode == 401) {
      throw ApiException(
        error: ApiError.unauthorized,
        statusCode: response.statusCode,
        statusMessage: response.statusMessage
      );
    } else if (response.statusCode == 403) {
      throw ApiException(
        error: ApiError.forbidden,
        statusCode: response.statusCode,
        statusMessage: response.statusMessage
      );
    } else if (response.statusCode == 404) {
      throw ApiException(
        error: ApiError.notFound,
        statusCode: response.statusCode,
        statusMessage: response.statusMessage
      );
    } else if (response.statusCode == 500 || response.statusCode == 503) {
      throw ApiException(
        error: ApiError.internalServerError,
        statusCode: response.statusCode,
        statusMessage: response.statusMessage
      );
    } else if (![200, 201, 202].contains(response.statusCode)) {
      throw ApiException(
        error: ApiError.unknowError,
        statusCode: response.statusCode,
        statusMessage: response.statusMessage
      );
    }
  }
}

// Modèle de reponse de l'API
class ApiResponse<T> {
  final T? data;
  final int? statusCode;

  ApiResponse(this.data, this.statusCode);
}

// Codification des erreurs de retour de l'API
enum ApiError {
  //
  /// The exception for an expired bearer token.
  tokenExpired,

  /// The exception for a failed connection attempt.
  timeOut,

  /// The exception for no internet connectivity.
  noInternetConnection,

  /// The exception for an incorrect parameter in a request/response.
  badRequest,

  /// The exception for an unauthorizeed api call
  unauthorized,

  // The exception for a forbidden action (403)
  forbidden,

  /// Not found
  notFound,

  // Erreur api interne
  internalServerError,

  /// The exception for an unknown exception from the api.
  unknowError,

  /// The exception for an unknown type of failure.
  unrecognizedError,

  /// The exception for any parsing failure encountered during
  /// serialization/deserialization of a request.
  serializationError,
}

/// Modele de réponse de l'API en cas d'erreur
class ApiProblem {
  final String type;
  final String title;
  final int status;
  final String detail;
  final Map<String, dynamic>? invalidParams;
  final Map<String, dynamic>? object;

  ApiProblem({
    required this.type,
    required this.title,
    required this.status,
    required this.detail,
    this.invalidParams,
    this.object,
  });

  factory ApiProblem.fromJson(Map<String, dynamic> json) {
    return ApiProblem(
      type: json['type'] ?? '',
      title: json['title'] ?? '',
      status: json['status'] ?? 0,
      detail: json['detail'] ?? '',
      invalidParams: json['invalid-params'],
      object: json['object'],
    );
  }

  @override
  String toString() {
    return 'ApiProblem{type: $type, title: $title, status: $status,'
        'detail: $detail, invalidParams: $invalidParams, object: $object}';
  }
}

/// Classe d'exception custom pour les erreurs d'appels vers les APis
class ApiException implements Exception {
  //
  final int? statusCode;
  final String? statusMessage;
  final ApiError error;
  late final String? name;
  late final String? message;
  late final ApiProblem? problem;

  ApiException({
    required this.statusCode, //
    required this.statusMessage,
    required this.error,
    this.message, //
    this.name,
    this.problem,
  });
}

/// Ajoute le token avant chaque requête
class TokenInterceptor extends Interceptor {
  //
  static const accessTokenKey = 'ACCESS_TOKEN';

  final Dio client;

  TokenInterceptor(this.client);

  /// Ajouter le token avant chaque requête
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // lire le token
    String? accessToken = await AppSecureStorage.get(accessTokenKey);
    // String? accessToken =
    //     "eyJhbGciOiJSUzI1NiIsInR5cCIgOiAiSldUIiwia2lkIiA6ICJrUjg1bDFBV0VaME90NUNya2dHU205WVRRVFRsSnZvX0NkWWQ1bG5sVExJIn0.eyJleHAiOjE3MDIwNzYyNjUsImlhdCI6MTcwMjA2OTA2NSwianRpIjoiYTMyYjY3ZTYtODA4MC00M2I4LTk2MjAtOTRmYTU5Yzk0ZDZmIiwiaXNzIjoiaHR0cHM6Ly9waS5hcHBtb2JpbGUucG9jcy1iY2Vhby5jb206ODQ0My9yZWFsbXMvcGktYXBwLW1vYmlsZSIsImF1ZCI6ImFjY291bnQiLCJzdWIiOiI0ZjZkZTVlYy1jNjQzLTQ2ZTUtOGU3Yy05NWM2YTA1NTRkZmEiLCJ0eXAiOiJCZWFyZXIiLCJhenAiOiJhcGktbW9iaWxlIiwic2Vzc2lvbl9zdGF0ZSI6ImY0MjNkYjgxLTIzYTktNDcyZi1hODU4LWY4ZWNiMGRiOGM0NyIsImFjciI6IjEiLCJyZWFsbV9hY2Nlc3MiOnsicm9sZXMiOlsiZGVmYXVsdC1yb2xlcy1waS1hcHAtbW9iaWxlIiwib2ZmbGluZV9hY2Nlc3MiLCJ1bWFfYXV0aG9yaXphdGlvbiJdfSwicmVzb3VyY2VfYWNjZXNzIjp7ImFjY291bnQiOnsicm9sZXMiOlsibWFuYWdlLWFjY291bnQiLCJtYW5hZ2UtYWNjb3VudC1saW5rcyIsInZpZXctcHJvZmlsZSJdfX0sInNjb3BlIjoiZW1haWwgcHJvZmlsZSIsInNpZCI6ImY0MjNkYjgxLTIzYTktNDcyZi1hODU4LWY4ZWNiMGRiOGM0NyIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJuYW1lIjoiU2FsaW8gU2VpbmkiLCJwcmVmZXJyZWRfdXNlcm5hbWUiOiJzc2VpbmkiLCJnaXZlbl9uYW1lIjoiU2FsaW8iLCJmYW1pbHlfbmFtZSI6IlNlaW5pIiwiZW1haWwiOiJzc2VpbmlAYmNlYW8uaW50In0.KYyTfUtnduNhRZ-Qp12CSsnX3H0zc341LMs3gjGKgabn9AejE5dVgfNiyVrrJe04ovIdLm2lXFk3wwJEcd5odDBYFtXRWFm_3d_lAzs7tmlyMW7P0OgVHtOotShqXIcO6UlBxAWbIdLMAc9lBxB4eBjQjZAgIxXgRmZV3EKCbDUWOEItBKTH_aBXXDYWkISX7sX6kdxkodKzOBVo385Rp5hkievVJuF06R8DYu6My7HclICVyBZC1Ed5P26aMYzuV81eHbetlnAsVa9xR-qR5EUP_vJENSLhR_3ACgtGVgVXIa8hUdj8MYOovH0aQek5Jay9tHaEB2LF1b7HsK7QNA"; //

    debugPrint(accessToken);
    AppLogger.info("Requete accessToken $accessToken");
    // Ajouter le jeton utilisateur à la demande s'il existe
    options.headers['Authorization'] = 'Bearer $accessToken';
    return handler.next(options);
  }

  /// Si la session est expirée
  @override
  void onError(DioException error, ErrorInterceptorHandler handler) async {
    AppLogger.error("Error HTTP - dans Token interceptor", error: error);
    // Si c'est un problème d'autorisations
    if (error.response?.statusCode == 403) {
      // Si une réponse 401 est reçue, actualisez le jeton d'accès
      String newAccessToken = await refreshToken();
      // Mettre à jour l'en-tête de la requête avec le nouveau jeton d'accès
      error.requestOptions.headers['Authorization'] = 'Bearer $newAccessToken';
      // Répétez la demande avec l'en-tête mis à jour
      return handler.resolve(await client.fetch(error.requestOptions));
    }
    return handler.next(error);
  }

  static Future<String> refreshToken() async {
    // Effectuez une requête au point de terminaison du jeton d’actualisation
    // et renvoyez le nouveau jeton d’accès.
    return 'your_new_access_token';
  }
}

/// Pour logger ce qui se passe
class LoggingInterceptor extends Interceptor {

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    AppLogger.info('''--> ${options.method.toUpperCase()} 
        ${options.baseUrl} ${options.path}''');
    AppLogger.info("Request Headers:");
    options.headers.forEach((k, v) => AppLogger.info('$k: $v'));
    AppLogger.info("Request queryParameters:");
    options.queryParameters.forEach((k, v) => AppLogger.info('$k: $v'));
    if (options.data != null) {
      AppLogger.info("Request Body: ${options.data}");
    }
    return handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    AppLogger.info("<-- ${err.message} ${err.requestOptions.path}");
    AppLogger.info("${err.response != null ? err.response!.data : 'Unknown Error'}");
    AppLogger.info("<-- End error");
    return handler.next(err);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    AppLogger.info("<-- ${response.statusCode} ${response.requestOptions.path}");
    AppLogger.info("Response Headers:");
    response.headers.forEach((k, v) => AppLogger.info('$k: $v'));
    AppLogger.info('''Response:  ${response.statusCode} 
        ${response.requestOptions.path} ${response.data}''');
    return super.onResponse(response, handler);
  }
}

/// Pour gérer des erreurs personnalisées détaillées spécifiques
class ErrorInterceptor extends Interceptor {
  //
  ErrorInterceptor();

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    AppLogger.error("Error HTTP - dans Token interceptor", error: err);
    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        throw ApiException(
          error: ApiError.timeOut,
          statusCode: err.response?.statusCode,
          statusMessage: err.response?.statusMessage,
          message: err.message,
        );
      case DioExceptionType.connectionError:
        throw ApiException(
          error: ApiError.noInternetConnection,
          statusCode: err.response?.statusCode,
          statusMessage: err.response?.statusMessage,
          message: err.message,
        );
      case DioExceptionType.badResponse:
        throw ApiException(
          error: ApiError.badRequest,
          statusCode: err.response?.statusCode,
          statusMessage: err.response?.statusMessage,
        );
      default:
        
        throw ApiException(
          error: ApiError.unknowError,
          statusCode: err.response?.statusCode,
          statusMessage: err.response?.statusMessage,
          message: err.message,
        );
    }
  }
}
