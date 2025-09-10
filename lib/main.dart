import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mini_app/routes.dart';
import 'package:mini_app/routes_map.dart';
import 'package:mini_app/features/business/data/providers/business_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const HeyGenyMiniApp());
}

class HeyGenyMiniApp extends StatelessWidget {
  const HeyGenyMiniApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => BusinessProvider()),
      ],
      child: MaterialApp(
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurple,
          ),
          useMaterial3: true,
        ),
        initialRoute: Routes.splashScreen,
        routes: RoutesMap.routes,
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en', ''),
          Locale('fr', ''),
        ],
      ),
    );
  }
}
