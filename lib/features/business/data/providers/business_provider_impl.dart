import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:mini_app/core/api/api_response.dart';
import 'package:mini_app/core/local_storage/local_storage_implementation.dart';
import 'package:mini_app/core/local_storage/local_storage_service.dart';
import 'package:mini_app/features/business/data/providers/business_provider.dart';
import 'package:mini_app/features/business/data/services/business_service.dart';
import 'package:mini_app/features/business/models/business_model.dart';
import 'package:mini_app/utils/utils.dart';

class BusinessProviderImpl extends BusinessProvider {
  final BusinessService businessService;
  final LocalStorageService localStorageService;

  BusinessProviderImpl({required this.businessService, required this.localStorageService});

  List<Business> _businesses = [];

  @override
  List<Business> get businesses => _businesses;

  @override
  Future<ApiResponse<List<Business>>> fetchBusinesses() async {
    try {
      final response = await businessService.getBusinesses();
      if (response.data != null) {
        _businesses = response.data!;
        final convertedBusinesses = jsonEncode(_businesses.map((business) => business.toJson()).toList());
        localStorageService.setValue(HiveKeys.BUSINESSES, convertedBusinesses);
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
  Future<void> fetchBusinessesFromLocalStorage() async {
    try {
      final businesses = await localStorageService.getValue<String?>(HiveKeys.BUSINESSES);
      log('Hive value : $businesses');
      if (businesses != null) {
        final decodedBusinesses = jsonDecode(businesses) as List<dynamic>;
        _businesses = decodedBusinesses.map((business) => Business.fromJson(business)).toList().cast<Business>();
        notifyListeners();
      }
    } catch (e) {
      handleError(e);
      throw Exception(e);
    }
  }

  @override
  Future<ApiResponse<List<Business>>> fetchBusinessWithError() async {
    try {
      final response = await businessService.getBusinessesWithError();
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
