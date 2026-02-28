import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'features/splash/splash_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    // MOBILE APP only — Web app is handled by koutix_web (React)
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Koutix',
      theme: AppTheme.lightTheme,
      home: const SplashScreen(),
    );
  }
}
