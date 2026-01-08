import 'package:flutter/material.dart';
import '../analytics/analytics_screen.dart';
import '../branding/branding_screen.dart';
import '../pos/pos_screen.dart';
import '../settings/settings_screen.dart';
import '../stores/stores_screen.dart';
import '../../transactions/admin_transactions_screen.dart';
import 'dashboard_overview_screen.dart';

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = const [
    DashboardOverviewScreen(),
    StoresScreen(),
    AdminTransactionsScreen(),
    POSScreen(),
    BrandingScreen(),
    AnalyticsScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // SIDEBAR
          NavigationRail(
            backgroundColor: Theme.of(context).primaryColor,
            selectedIndex: _selectedIndex,
            onDestinationSelected: (int index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            labelType: NavigationRailLabelType.all,
            indicatorColor: Theme.of(context).colorScheme.secondary,
            selectedLabelTextStyle: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            unselectedLabelTextStyle: const TextStyle(color: Colors.white70),
            selectedIconTheme: IconThemeData(
              color: Theme.of(context).primaryColor,
            ),
            unselectedIconTheme: const IconThemeData(color: Colors.white70),
            destinations: const [
              NavigationRailDestination(
                icon: Icon(Icons.dashboard_outlined),
                selectedIcon: Icon(Icons.dashboard),
                label: Text('Dashboard'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.store_outlined),
                selectedIcon: Icon(Icons.store),
                label: Text('Stores'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.receipt_long_outlined),
                selectedIcon: Icon(Icons.receipt_long),
                label: Text('Transactions'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.point_of_sale_outlined),
                selectedIcon: Icon(Icons.point_of_sale),
                label: Text('POS'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.format_paint_outlined),
                selectedIcon: Icon(Icons.format_paint),
                label: Text('Branding'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.analytics_outlined),
                selectedIcon: Icon(Icons.analytics),
                label: Text('Analytics'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.settings_outlined),
                selectedIcon: Icon(Icons.settings),
                label: Text('Settings'),
              ),
            ],
            leading: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Image.asset(
                'assets/logo.png', // Fallback or placeholder needed if not exists
                width: 40,
                errorBuilder: (context, error, stackTrace) => const Icon(
                  Icons.admin_panel_settings,
                  color: Colors.white,
                  size: 40,
                ),
              ),
            ),
          ),
          const VerticalDivider(thickness: 1, width: 1),
          // MAIN CONTENT
          Expanded(child: _screens[_selectedIndex]),
        ],
      ),
    );
  }
}
