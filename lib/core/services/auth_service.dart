import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  static const String baseUrl = 'http://localhost:3000/api/auth/signup';

  Future<Map<String, dynamic>> login(String email, String password) async {
    final url = Uri.parse('$baseUrl/auth/login');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to login: ${response.body}');
      }
    } catch (e) {
      if (e.toString().contains('ClientException')) {
        throw Exception(
          'Login error: $e\nHint: If on Web, check CORS. If on Android Emulator, use 10.0.2.2 instead of localhost.',
        );
      }
      throw Exception('Login error: $e');
    }
  }

  Future<Map<String, dynamic>> signup(
    String supermarketName,
    String email,
    String password,
  ) async {
    final url = Uri.parse('$baseUrl/auth/signup');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'supermarketName': supermarketName,
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to sign up: ${response.body}');
      }
    } catch (e) {
      if (e.toString().contains('ClientException')) {
        throw Exception(
          'Sign up error: $e\nHint: If on Web, check CORS. If on Android Emulator, use 10.0.2.2 instead of localhost.',
        );
      }
      throw Exception('Sign up error: $e');
    }
  }
}
