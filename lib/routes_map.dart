import 'package:flutter/material.dart';
import 'package:mini_app/features/dashboard/presentation/dashboard.dart';
import 'package:mini_app/routes.dart';
import 'package:mini_app/splash_screen.dart';

class RoutesMap {
  static final Map<String, WidgetBuilder> routes = {
    Routes.splashScreen: (context) => const SplashScreen(),
    Routes.dashboard: (context) => const Dashboard(),
  };
}
