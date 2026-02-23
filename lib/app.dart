import 'package:flutter/material.dart';

import 'features/partner/dashboard/partner_home.dart';
import 'core/theme/app_theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    // MOBILE APP only — Web app is now handled by koutix_web (React)
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Koutix Partner',
      theme: AppTheme.lightTheme,
      home: const PartnerHomeScreen(),
    );
  }
}
