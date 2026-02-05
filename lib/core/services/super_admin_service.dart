import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import '../models/supermarket_chain_model.dart';
import 'auth_service.dart';

class SuperAdminService {
  final String baseUrl = AuthService.baseUrl;

  /// Fetch all pending chain manager approvals
  Future<List<SupermarketChain>> getPendingChainManagers() async {
    final url = Uri.parse('$baseUrl/superadmin/pending-chains');

    try {
      final user = FirebaseAuth.instance.currentUser;
      final token = await user?.getIdToken();

      final headers = {
        'Content-Type': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      };

      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => _fromJson(json)).toList();
      } else {
        throw Exception(
          'Failed to load pending chains: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Error fetching pending chains: $e');
    }
  }

  /// Approve a chain manager
  Future<void> approveChainManager(String chainId) async {
    final url = Uri.parse('$baseUrl/superadmin/approve-chain/$chainId');
    try {
      final user = FirebaseAuth.instance.currentUser;
      final token = await user?.getIdToken();

      final headers = {
        'Content-Type': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      };

      final response = await http.put(url, headers: headers);

      if (response.statusCode != 200) {
        final error = jsonDecode(response.body);
        throw Exception(error['message'] ?? 'Failed to approve chain');
      }
    } catch (e) {
      rethrow;
    }
  }

  /// Reject/Cancel a chain manager
  Future<void> rejectChainManager(String chainId) async {
    final url = Uri.parse('$baseUrl/superadmin/reject-chain/$chainId');
    try {
      final user = FirebaseAuth.instance.currentUser;
      final token = await user?.getIdToken();

      final headers = {
        'Content-Type': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      };

      final response = await http.put(url, headers: headers);

      if (response.statusCode != 200) {
        final error = jsonDecode(response.body);
        throw Exception(error['message'] ?? 'Failed to reject chain');
      }
    } catch (e) {
      rethrow;
    }
  }

  // Helper to map JSON to Model
  SupermarketChain _fromJson(Map<String, dynamic> json) {
    return SupermarketChain(
      id: json['_id'] ?? json['id'] ?? '',
      name: json['chainName'] ?? '',
      location: json['hqAddress'] ?? '',
      ownerName: json['fullName'] ?? '',
      contactNumber: json['phone'] ?? '',
      email: json['email'] ?? '',
      status: json['status'] ?? 'Pending',
      vatTrn: json['vatTrn'],
      tradeLicense: json['tradeLicense'],
      logoUrl: json['logoUrl'],
      primaryColor: json['primaryColor'],
      expectedBranchCount: json['expectedBranchCount'] is int
          ? json['expectedBranchCount']
          : int.tryParse(json['expectedBranchCount']?.toString() ?? '1'),
      posSystem: json['posSystem'],
      countryCode: json['countryCode'],
    );
  }
}
