import 'package:flutter/material.dart';
import 'package:koutix_app/features/landing/utils.dart';
import 'package:koutix_app/features/landing/widgets/sticky_text_content.dart';
import 'package:koutix_app/features/landing/widgets/design_card_item.dart';

class FeaturesSection extends StatelessWidget {
  const FeaturesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 100,
        horizontal: getResponsiveHorizontalPadding(context),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Header
          const StickyTextContent(),
          const SizedBox(height: 60),

          // New Horizontal Card Container
          ClipRRect(
            borderRadius: BorderRadius.circular(32),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final isDesktop = constraints.maxWidth > 900;

                if (!isDesktop) {
                  return Column(
                    children: [
                      DesignCardItem(
                        icon: Icons.receipt_outlined,
                        title: 'Fast & Reliable Billing Software',
                        description:
                            'Process customer bills quickly with a stable, secure billing system designed for high-volume supermarket counters.',
                      ),
                      Divider(height: 60, color: Colors.grey.shade300),
                      DesignCardItem(
                        icon: Icons.inventory_2_outlined,
                        title: 'Inventory & Stock Management',
                        description:
                            'Track stock movement in real time, monitor low-stock items, and prevent over-ordering or wastage.',
                      ),
                      Divider(height: 60, color: Colors.grey.shade300),
                      DesignCardItem(
                        icon: Icons.people_outline,
                        title: 'Staff & Counter Management',
                        description:
                            'Assign staff roles, manage counters, and control access levels with full transparency.',
                      ),
                      Divider(height: 60, color: Colors.grey.shade300),
                      DesignCardItem(
                        icon: Icons.bar_chart_outlined,
                        title: 'Sales Reports & Business Insights',
                        description:
                            'View daily, weekly, and monthly sales reports to understand performance and make better business decisions.',
                      ),
                    ],
                  );
                }

                return Column(
                  children: [
                    IntrinsicHeight(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: DesignCardItem(
                              icon: Icons.receipt_outlined,
                              title: 'Fast & Reliable Billing Software',
                              description:
                                  'Process customer bills quickly with a stable, secure billing system designed for high-volume supermarket counters.',
                            ),
                          ),
                          VerticalDivider(width: 60, color: Colors.white12),
                          Expanded(
                            child: DesignCardItem(
                              icon: Icons.inventory_2_outlined,
                              title: 'Inventory & Stock Management',
                              description:
                                  'Track stock movement in real time, monitor low-stock items, and prevent over-ordering or wastage.',
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(height: 60, color: Colors.white12),
                    IntrinsicHeight(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: DesignCardItem(
                              icon: Icons.people_outline,
                              title: 'Staff & Counter Management',
                              description:
                                  'Assign staff roles, manage counters, and control access levels with full transparency.',
                            ),
                          ),
                          VerticalDivider(width: 60, color: Colors.white12),
                          Expanded(
                            child: DesignCardItem(
                              icon: Icons.bar_chart_outlined,
                              title: 'Sales Reports & Business Insights',
                              description:
                                  'View daily, weekly, and monthly sales reports to understand performance and make better business decisions.',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
