import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  // Update this to your production server URL when deploying
  static const String baseUrl = 'http://172.20.10.5:3001/api';

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  /// Login using Firebase and then authenticate with Koutix Server
  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      // 1. Sign in with Firebase
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      // 2. Get ID Token
      String? idToken = await userCredential.user?.getIdToken();
      if (idToken == null) {
        throw Exception('Failed to get ID token from Firebase');
      }

      // 3. Send ID Token to Koutix Server
      final url = Uri.parse('$baseUrl/auth/login');
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'idToken': idToken}),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        final error = jsonDecode(response.body);
        throw Exception(error['message'] ?? 'Failed to login to server');
      }
    } catch (e) {
      rethrow;
    }
  }

  /// Signup as a Chain Manager
  Future<Map<String, dynamic>> signupChainManager({
    required String email,
    required String password,
    required String fullName,
    required String phone,
    required String chainName,
    String? vatTrn,
    String? hqAddress,
    String? tradeLicense,
    String? logoUrl,
    String? primaryColor,
    int? expectedBranchCount,
    String? posSystem,
    String? countryCode,
  }) async {
    final url = Uri.parse('$baseUrl/auth/signup-chain-manager');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
          'fullName': fullName,
          'phone': phone,
          'chainName': chainName,
          'vatTrn': vatTrn,
          'hqAddress': hqAddress,
          'tradeLicense': tradeLicense,
          'logoUrl': logoUrl,
          'primaryColor': primaryColor,
          'expectedBranchCount': expectedBranchCount,
          'posSystem': posSystem,
          'countryCode': countryCode,
        }),
      );

      if (response.statusCode == 201) {
        return jsonDecode(response.body);
      } else {
        final error = jsonDecode(response.body);
        throw Exception(
          error['message'] ?? 'Failed to signup as Chain Manager',
        );
      }
    } catch (e) {
      rethrow;
    }
  }

  /// Signup as a Branch Manager or Independent Supermarket Owner
  Future<Map<String, dynamic>> signupBranchManager({
    required String email,
    required String password,
    required String fullName,
    required String phoneNumber,
    required String branchName,
    required String address,
    String? vatTrn,
    String? tradeLicense,
    String? logoUrl,
    String? primaryColor,
    required int expectedBranchCount,
    required String posSystem,
  }) async {
    final url = Uri.parse('$baseUrl/auth/signup-branch-manager');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
          'fullName': fullName,
          'phoneNumber': phoneNumber,
          'branchName': branchName,
          'address': address,
          'vatTrn': vatTrn,
          'tradeLicense': tradeLicense,
          'logoUrl': logoUrl,
          'primaryColor': primaryColor,
          'expectedBranchCount': expectedBranchCount,
          'posSystem': posSystem,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(response.body);
      } else {
        final error = jsonDecode(response.body);
        throw Exception(
          error['message'] ?? 'Failed to signup as Branch Manager',
        );
      }
    } catch (e) {
      rethrow;
    }
  }

  /// Verify an invitation token (for Branch Managers)
  Future<Map<String, dynamic>> verifyInvitation(String token) async {
    final url = Uri.parse('$baseUrl/auth/verify-invitation?token=$token');
    try {
      final response = await http.get(
        url,
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        final error = jsonDecode(response.body);
        throw Exception(error['message'] ?? 'Invalid or expired invitation');
      }
    } catch (e) {
      rethrow;
    }
  }

  /// Complete onboarding for Branch Manager (Invited)
  Future<Map<String, dynamic>> completeOnboarding({
    required String token,
    required String password,
    required String displayName,
  }) async {
    final url = Uri.parse('$baseUrl/auth/complete-onboarding');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'token': token,
          'password': password,
          'displayName': displayName,
        }),
      );

      if (response.statusCode == 201) {
        return jsonDecode(response.body);
      } else {
        final error = jsonDecode(response.body);
        throw Exception(error['message'] ?? 'Failed to complete onboarding');
      }
    } catch (e) {
      rethrow;
    }
  }

  /// Forgot Password
  Future<void> forgotPassword(String email) async {
    final url = Uri.parse('$baseUrl/auth/forgot-password');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email}),
      );

      if (response.statusCode != 200) {
        final error = jsonDecode(response.body);
        throw Exception(error['message'] ?? 'Failed to generate reset link');
      }
    } catch (e) {
      rethrow;
    }
  }

  /// Logout
  Future<void> logout() async {
    await _firebaseAuth.signOut();
  }
}
