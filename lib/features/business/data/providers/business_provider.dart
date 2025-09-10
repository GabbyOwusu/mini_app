import 'package:flutter/material.dart';
import 'package:mini_app/core/api/api_response.dart';
import 'package:mini_app/features/business/models/business_model.dart';

abstract class BusinessProvider extends ChangeNotifier {
  List<Business> get businesses;

  Future<ApiResponse<List<Business>>> fetchBusinesses();

  Future<ApiResponse<List<Business>>> fetchBusinessWithError();
}
