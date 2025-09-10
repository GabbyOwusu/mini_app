import 'package:mini_app/core/api/api_response.dart';
import 'package:mini_app/features/business/models/business_model.dart';

abstract class BusinessService {
  Future<ApiResponse<List<Business>>> getBusinesses();

  Future<ApiResponse<List<Business>>> getBusinessesWithError();
}
