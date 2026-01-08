import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'features/partner/dashboard/partner_home.dart';
import 'core/theme/app_theme.dart';
import 'features/landing/landing_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      // WEB APP (Admin)
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Koutix Admin',
        theme: AppTheme.lightTheme,
        home: const LandingPage(),
      );
    } else {
      // MOBILE APP (Partner – later)
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Koutix Partner',
        theme: AppTheme.lightTheme,
        home: const PartnerHomeScreen(),
      );
    }
  }
}
