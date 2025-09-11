import 'package:mini_app/core/api/api_service.dart';
import 'package:dio/dio.dart';
import 'package:mini_app/core/interceptors/interceptors.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:mini_app/utils/constants.dart';

class ApiServiceImpl extends ApiService {
  late Dio _dio;

  @override
  void init({
    Duration connectTimeout = AppConstants.connectTimeout,
    Duration receiveTimeout = AppConstants.receiveTimeout,
    Duration sendTimeout = AppConstants.sendTimeout,
    bool shouldRetryRequest = true,
    int maxRetries = AppConstants.maxRetries,
    Duration initialRetryDelay = AppConstants.initialRetryDelay,
    double retryMultiplier = AppConstants.retryMultiplier,
    Duration maxRetryDelay = AppConstants.maxRetryDelay,
  }) {
    const baseUrl = AppConstants.baseUrl;
    final baseOptions = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: connectTimeout,
      receiveTimeout: receiveTimeout,
      sendTimeout: sendTimeout,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );

    _dio = Dio(baseOptions);

    if (shouldRetryRequest) {
      _dio.interceptors.add(RetryInterceptor(
        maxRetries: maxRetries,
        initialDelay: initialRetryDelay,
        multiplier: retryMultiplier,
        maxDelay: maxRetryDelay,
      ));
    }

    _dio.interceptors.add(AuthInterceptor());
    _dio.interceptors.add(LoadingDelayInterceptor(
      delay: AppConstants.loadingDelay,
      enableDelay: AppConstants.enableLoadingDelay,
    ));

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          if (options.path == '/error') {
            return handler.reject(DioException(
              requestOptions: options,
              response: Response(
                requestOptions: options,
                statusCode: 500,
                data: {'message': 'Internal Server Error'},
              ),
            ));
          }

          if (options.path == '/empty') {
            return handler.resolve(
              Response(
                requestOptions: options,
                data: [],
                statusCode: 200,
              ),
            );
          }

          final String jsonString = await rootBundle.loadString('db.json');
          final List<dynamic> jsonData = json.decode(jsonString);
          return handler.resolve(
            Response(
              requestOptions: options,
              data: jsonData,
              statusCode: 200,
            ),
          );
        },
      ),
    );
  }

  @override
  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.get<T>(
        path,
        queryParameters: queryParameters,
      );
      return response;
    } on DioException catch (e) {
      throw Exception(e);
    }
  }
}
