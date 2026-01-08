import 'package:flutter/material.dart';

class DashboardOverviewScreen extends StatelessWidget {
  const DashboardOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Using a ScrollView to ensure it fits on smaller laptop screens
    return Scaffold(
      backgroundColor: Colors.grey[50], // Slight contrast from white cards
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // HEADER
            const Text(
              'Dashboard Overview',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4A171E), // Primary Burgundy
                letterSpacing: -0.5,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Welcome back, Super Admin',
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
            const SizedBox(height: 32),

            // METRICS GRID
            LayoutBuilder(
              builder: (context, constraints) {
                // Responsive grid: 4 columns on large screens, 2 on medium, 1 on small
                int crossAxisCount = constraints.maxWidth > 1200
                    ? 4
                    : constraints.maxWidth > 800
                    ? 2
                    : 1;
                double childAspectRatio = constraints.maxWidth > 1200
                    ? 1.4
                    : 1.6;

                return GridView.count(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  childAspectRatio: childAspectRatio,
                  children: const [
                    _MetricCard(
                      title: 'Total Stores',
                      value: '12',
                      icon: Icons.store,
                      color: Color(0xFF4A171E), // Burgundy
                      trend: '+2 this month',
                      trendColor: Colors.green,
                    ),
                    _MetricCard(
                      title: 'Active POS',
                      value: '45/48',
                      icon: Icons.point_of_sale,
                      color: Color(0xFFE2B144), // Gold
                      trend: '94% Online',
                      trendColor: Colors.green,
                    ),
                    _MetricCard(
                      title: 'Transactions (Today)',
                      value: '1,284',
                      icon: Icons.receipt_long,
                      color: Colors.blueAccent,
                      trend: '+12% vs yesterday',
                      trendColor: Colors.green,
                    ),
                    _MetricCard(
                      title: 'System Alerts',
                      value: '3',
                      icon: Icons.notifications_active,
                      color: Colors.redAccent,
                      trend: 'Action Required',
                      trendColor: Colors.red,
                    ),
                  ],
                );
              },
            ),

            const SizedBox(height: 32),

            // SECTION: QUICK ACTIONS or RECENT ACTIVITY (Placeholder)
            const Text(
              'Recent System Activity',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              height: 300,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Center(
                child: Text(
                  'Activity Log Graph / Table Placeholder',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MetricCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;
  final String trend;
  final Color trendColor;

  const _MetricCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
    required this.trend,
    required this.trendColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: color, size: 24),
              ),
              // Optional: More options icon
            ],
          ),
          const Spacer(),
          Text(
            value,
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(
                trendColor == Colors.green
                    ? Icons.arrow_upward
                    : Icons.warning_amber_rounded,
                size: 16,
                color: trendColor,
              ),
              const SizedBox(width: 4),
              Text(
                trend,
                style: TextStyle(
                  fontSize: 12,
                  color: trendColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
