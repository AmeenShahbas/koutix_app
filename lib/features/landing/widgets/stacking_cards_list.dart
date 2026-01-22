import 'package:flutter/material.dart';
import 'package:koutix_app/features/landing/widgets/stack_info_card.dart';

class StackingCardsList extends StatelessWidget {
  const StackingCardsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StackInfoCard(
          index: 0,
          color: Colors.blue[500]!,
          icon: Icons.receipt_outlined,
          title: 'Fast & Reliable Billing Software',
          description:
              'Process customer bills quickly with a stable, secure billing system designed for high-volume supermarket counters.',
          chartData: const [0.3, 0.5, 0.4, 0.7, 0.6, 0.8, 0.5],
        ),
        StackInfoCard(
          index: 1,
          color: Colors.green[500]!, // Green for inventory
          icon: Icons.inventory_2_outlined,
          title: 'Inventory & Stock Management',
          description:
              'Track stock movement in real time, monitor low-stock items, and prevent over-ordering or wastage.',
          topOffset: -40, // Stacking effect
          chartData: const [0.5, 0.6, 0.8, 0.4, 0.7, 0.5, 0.6],
        ),
        StackInfoCard(
          index: 2,
          color: Colors.orange[500]!, // Orange for staff
          icon: Icons.people_outline,
          title: 'Staff & Counter Management',
          description:
              'Assign staff roles, manage counters, and control access levels with full transparency.',
          topOffset: -40, // Stacking effect
          chartData: const [0.2, 0.4, 0.3, 0.5, 0.4, 0.6, 0.4],
        ),
        StackInfoCard(
          index: 3,
          color: Colors.purple[500]!, // Purple for insights
          icon: Icons.bar_chart_outlined,
          title: 'Sales Reports & Business Insights',
          description:
              'View daily, weekly, and monthly sales reports to understand performance and make better business decisions.',
          topOffset: -40, // Stacking effect
          chartData: const [0.4, 0.6, 0.5, 0.8, 0.9, 0.7, 0.9],
        ),
      ],
    );
  }
}
