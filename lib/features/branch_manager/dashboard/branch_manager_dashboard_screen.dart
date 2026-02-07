import 'package:flutter/material.dart';

class BranchManagerDashboardScreen extends StatefulWidget {
  const BranchManagerDashboardScreen({super.key});

  @override
  State<BranchManagerDashboardScreen> createState() =>
      _BranchManagerDashboardScreenState();
}

class _BranchManagerDashboardScreenState
    extends State<BranchManagerDashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Branch Manager Dashboard"),
        centerTitle: true,
      ),
      body: const Center(child: Text("Branch Manager Dashboard")),
    );
  }
}
