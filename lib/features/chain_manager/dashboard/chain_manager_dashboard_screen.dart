import 'package:flutter/material.dart';

class ChainManagerDashboardScreen extends StatefulWidget {
  const ChainManagerDashboardScreen({super.key});

  @override
  State<ChainManagerDashboardScreen> createState() =>
      _ChainManagerDashboardScreenState();
}

class _ChainManagerDashboardScreenState
    extends State<ChainManagerDashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chain Manager Dashboard"),
        centerTitle: true,
      ),
      body: const Center(child: Text("Chain Manager Dashboard")),
    );
  }
}
