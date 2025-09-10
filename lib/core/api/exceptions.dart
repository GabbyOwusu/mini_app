import 'package:dio/dio.dart';

String errorMessageHandler(DioException e) {
  switch (e.type) {
    case DioExceptionType.connectionTimeout:
    case DioExceptionType.sendTimeout:
    case DioExceptionType.receiveTimeout:
    case DioExceptionType.connectionError:
      return 'Oops! It looks like your internet connection is having trouble. Please check your connection and give it another try.';

    case DioExceptionType.badResponse:
      final statusCode = e.response?.statusCode;
      switch (statusCode) {
        case 400:
          return 'Something went wrong with your request. Please double-check and try again.';
        case 401:
          return 'It looks like you need to sign in again. Please log in to continue.';
        case 403:
          return 'Sorry, you don\'t have permission to access this. Please contact support if you think this is a mistake.';
        case 404:
          return 'We couldn\'t find what you\'re looking for. The businesses might have moved or been removed.';
        case 500:
          return 'Something went wrong on our end. Please hang tight and try again in a moment.';
        default:
          return 'We encountered an unexpected issue: ${e.response?.data?['message'] ?? 'Something unexpected happened'}';
      }
    default:
      return 'We\'re having trouble connecting right now';
  }
}
