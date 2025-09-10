import 'package:dio/dio.dart';

typedef ObjectCreator<S> = S Function(Map<String, dynamic> json);
typedef ListCreator<S> = S Function(List<dynamic> json);

class ApiResponse<T> {
  T? data;
  String? errorMessage;

  ApiResponse({this.data, this.errorMessage});

  ApiResponse.fromJsonList({
    required Response response,
    required ListCreator<T> creator,
  }) {
    try {
      if (response.data != null) {
        final responseBody = response.data as List<dynamic>;
        data = creator(responseBody);
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
