import 'package:get_it/get_it.dart';
import 'package:mini_app/core/api/api_service.dart';
import 'package:mini_app/core/api/api_service_impl.dart';
import 'package:mini_app/features/business/data/providers/business_provider.dart';
import 'package:mini_app/features/business/data/providers/business_provider_impl.dart';
import 'package:mini_app/features/business/data/services/business_service.dart';
import 'package:mini_app/features/business/data/services/business_service_impl.dart';

GetIt sl = GetIt.instance;

void setupServiceLocator() {
  sl.registerLazySingleton<ApiService>(() => ApiServiceImpl()..init());
  sl.registerLazySingleton<BusinessService>(() => BusinessServiceImpl(apiService: sl<ApiService>()));
  sl.registerLazySingleton<BusinessProvider>(() => BusinessProviderImpl(businessService: sl<BusinessService>()));
}
