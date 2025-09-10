import 'package:dio/dio.dart';
import 'package:mini_app/core/api/api_response.dart';
import 'package:mini_app/core/api/api_service.dart';
import 'package:mini_app/features/business/data/services/business_service.dart';
import 'package:mini_app/features/business/models/business_model.dart';

class BusinessServiceImpl extends BusinessService {
  final ApiService apiService;

  BusinessServiceImpl({required this.apiService});

  @override
  Future<ApiResponse<List<Business>>> getBusinesses() async {
    try {
      final response = await apiService.get('/businesses');
      return ApiResponse.fromJsonList(
        response: response,
        creator: (list) => list.map((json) {
          return Business.fromJson(json);
        }).toList(),
      );
    } on DioException catch (_) {
      rethrow;
    }
  }

  @override
  Future<ApiResponse<List<Business>>> getBusinessesWithError() async {
    try {
      final response = await apiService.get('/error');
      return ApiResponse.fromJsonList(
        response: response,
        creator: (list) => list.map((json) {
          return Business.fromJson(json);
        }).toList(),
      );
    } on DioException catch (_) {
      rethrow;
    }
  }
}
