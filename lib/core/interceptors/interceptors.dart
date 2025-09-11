import 'package:dio/dio.dart';
import 'dart:math';
import 'dart:async';

class RetryInterceptor extends Interceptor {
  final int maxRetries;
  final Duration initialDelay;
  final double multiplier;
  final Duration maxDelay;
  final List<int> retryStatusCodes;

  RetryInterceptor({
    this.maxRetries = 3,
    this.initialDelay = const Duration(milliseconds: 500),
    this.multiplier = 2.0,
    this.maxDelay = const Duration(seconds: 30),
    this.retryStatusCodes = const [408, 429, 500, 502, 503, 504],
  });

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final extra = err.requestOptions.extra;
    final retryCount = extra['retry_count'] ?? 0;

    if (_shouldRetry(err, retryCount)) {
      final delay = _calculateDelay(retryCount);
      err.requestOptions.extra['retry_count'] = retryCount + 1;
      await Future.delayed(delay);
      try {
        final response = await Dio().fetch(err.requestOptions);
        handler.resolve(response);
      } catch (e) {
        if (e is DioException) {
          onError(e, handler);
        } else {
          handler.reject(err);
        }
      }
    } else {
      handler.reject(err);
    }
  }

  bool _shouldRetry(DioException err, int retryCount) {
    if (retryCount >= maxRetries) return false;
    if (err.type == DioExceptionType.connectionTimeout ||
        err.type == DioExceptionType.sendTimeout ||
        err.type == DioExceptionType.receiveTimeout ||
        err.type == DioExceptionType.connectionError) {
      return true;
    }
    if (err.response?.statusCode != null && retryStatusCodes.contains(err.response!.statusCode)) {
      return true;
    }
    return false;
  }

  Duration _calculateDelay(int retryCount) {
    final delay = Duration(
      milliseconds: (initialDelay.inMilliseconds * pow(multiplier, retryCount)).round(),
    );
    final jitter = Random().nextInt(100);
    final delayWithJitter = Duration(milliseconds: delay.inMilliseconds + jitter);
    return delayWithJitter > maxDelay ? maxDelay : delayWithJitter;
  }
}

class AuthInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    const token = 'myToken';
    options.headers['Authorization'] = 'Bearer $token';
    return handler.next(options);
  }
}

class LoadingDelayInterceptor extends Interceptor {
  final Duration delay;
  final bool enableDelay;

  LoadingDelayInterceptor({required this.delay, required this.enableDelay});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    if (enableDelay) {
      await Future.delayed(delay);
      return handler.next(options);
    } else {
      return handler.next(options);
    }
  }
}
