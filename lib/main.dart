import 'package:flutter/material.dart';
import 'package:mini_app/splash_screen.dart';

void main() {
  runApp(const HeyGenyMiniApp());
}

class HeyGenyMiniApp extends StatelessWidget {
  const HeyGenyMiniApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
