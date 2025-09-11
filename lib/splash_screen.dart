import 'package:flutter/material.dart';
import 'package:mini_app/features/business/data/providers/business_provider.dart';
import 'package:mini_app/routes.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void handleSplashScreen() async {
    final businessProvider = context.read<BusinessProvider>();
    await businessProvider.fetchBusinessesFromLocalStorage();
    Navigator.pushReplacementNamed(context, Routes.dashboard);
  }

  @override
  void initState() {
    super.initState();
    handleSplashScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: const Text(
        'Splash Screen',
        style: TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
        ),
      )),
    );
  }
}
