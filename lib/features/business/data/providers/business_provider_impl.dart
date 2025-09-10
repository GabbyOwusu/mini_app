import 'package:dio/dio.dart';
import 'package:mini_app/core/api/api_response.dart';
import 'package:mini_app/features/business/data/providers/business_provider.dart';
import 'package:mini_app/features/business/data/services/business_service.dart';
import 'package:mini_app/features/business/models/business_model.dart';
import 'package:mini_app/utils/utils.dart';

class BusinessProviderImpl extends BusinessProvider {
  final BusinessService businessService;

  BusinessProviderImpl({required this.businessService});

  List<Business> _businesses = [];

  @override
  List<Business> get businesses => _businesses;

  @override
  Future<ApiResponse<List<Business>>> fetchBusinesses() async {
    try {
      final response = await businessService.getBusinesses();
      if (response.data != null) {
        _businesses = response.data!;
        notifyListeners();
      }
      return response;
    } on DioException catch (e) {
      handleError(e);
      return ApiResponse(
        data: <Business>[],
        errorMessage: e.toString(),
      );
    } catch (e) {
      handleError(e);
      return ApiResponse(
        data: <Business>[],
        errorMessage: 'An unexpected error occurred: $e',
      );
    }
  }

  @override
  Future<ApiResponse<List<Business>>> fetchBusinessWithError() async {
    try {
      final response = await businessService.getBusinesses();
      if (response.data != null) {
        _businesses = response.data!;
        notifyListeners();
      }
      return response;
    } catch (e) {
      handleError(e);
      return ApiResponse(
        data: <Business>[],
        errorMessage: 'An unexpected error occurred: $e',
      );
    }
  }
}
