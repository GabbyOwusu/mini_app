import 'package:get_it/get_it.dart';
import 'package:mini_app/core/api_service.dart';
import 'package:mini_app/core/api_service_impl.dart';

GetIt sl = GetIt.instance;

void setupServiceLocator() {
  sl.registerLazySingleton<ApiService>(() => ApiServiceImpl());
}
