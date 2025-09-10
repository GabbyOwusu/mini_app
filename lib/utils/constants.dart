class AppConstants {
  // API Configuration
  static const String baseUrl = 'https://api.example.com';
  static const String apiVersion = 'v1';

  // Timeout configurations
  static const Duration connectTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
  static const Duration sendTimeout = Duration(seconds: 30);

  // Retry configuration
  static const int maxRetries = 3;
  static const Duration initialRetryDelay = Duration(milliseconds: 500);
  static const double retryMultiplier = 2.0;
  static const Duration maxRetryDelay = Duration(seconds: 30);
}
