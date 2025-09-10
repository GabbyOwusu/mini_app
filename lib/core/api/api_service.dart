import 'package:dio/dio.dart';

abstract class ApiService {
  void init({
    Duration connectTimeout = const Duration(seconds: 30),
    Duration receiveTimeout = const Duration(seconds: 30),
    Duration sendTimeout = const Duration(seconds: 30),
    bool shouldRetryRequest = true,
    int maxRetries = 3,
    Duration initialRetryDelay = const Duration(milliseconds: 500),
    double retryMultiplier = 2.0,
    Duration maxRetryDelay = const Duration(seconds: 30),
  });

  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
  });
}
