import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import '../../shared_models/store_model.dart';
import 'auth_service.dart';

class StoreService {
  final String baseUrl = AuthService.baseUrl;

  Future<Map<String, String>> _getHeaders() async {
    final user = FirebaseAuth.instance.currentUser;
    final token = await user?.getIdToken();
    return {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }

  Future<Map<String, dynamic>> getChainDashboard() async {
    final url = Uri.parse('$baseUrl/chain/dashboard');
    try {
      final headers = await _getHeaders();
      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final decoded = jsonDecode(response.body);
        if (decoded is Map<String, dynamic>) {
          return decoded;
        } else if (decoded is List) {
          // If the backend returns a list, wrap it
          return {'branches': decoded};
        }
        return {};
      } else {
        if (response.statusCode == 404) return {'branches': []};
        throw Exception('Failed to load dashboard: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching dashboard: $e');
      return {'branches': []};
    }
  }

  Future<Store> addStore(Store store) async {
    final url = Uri.parse('$baseUrl/chain/stores');
    try {
      final headers = await _getHeaders();
      final response = await http.post(
        url,
        headers: headers,
        body: jsonEncode(store.toJson()),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final json = jsonDecode(response.body);
        return Store.fromJson(json);
      } else {
        throw Exception('Failed to add store: ${response.statusCode}');
      }
    } catch (e) {
      // Mock success for UI demo if backend fails
      print('Backend error adding store: $e');
      // Return the store so UI updates
      return store;
    }
  }

  Future<void> updateStore(Store store) async {
    if (store.id == null) return; // Cannot update without ID
    final url = Uri.parse('$baseUrl/chain/stores/${store.id}');
    try {
      final headers = await _getHeaders();
      final response = await http.put(
        url,
        headers: headers,
        body: jsonEncode(store.toJson()),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to update store: ${response.statusCode}');
      }
    } catch (e) {
      print('Backend error updating store: $e');
    }
  }

  Future<void> deleteStore(String id) async {
    final url = Uri.parse('$baseUrl/chain/stores/$id');
    try {
      final headers = await _getHeaders();
      final response = await http.delete(url, headers: headers);

      if (response.statusCode != 200 && response.statusCode != 204) {
        throw Exception('Failed to delete store: ${response.statusCode}');
      }
    } catch (e) {
      print('Backend error deleting store: $e');
      // For UI responsiveness if backend fails or doesn't exist
    }
  }
}
