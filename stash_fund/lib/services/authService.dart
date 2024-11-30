import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:stash_fund/components/ids.dart';

class AuthService {
  final String baseUrl = "${server_url}/api/auth"; // Replace with your actual backend URL

  // Signup API
  Future<Map<String, dynamic>> signup(String name, String email, String password) async {
    final url = Uri.parse("$baseUrl/signup");
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"name": name, "email": email, "password": password}),
    );

    if (response.statusCode == 201) {
      return {"success": true, "message": jsonDecode(response.body)};
    } else {
      return {"success": false, "message": jsonDecode(response.body)["message"]};
    }
  }

  // Login API
  Future<Map<String, dynamic>> login(String email, String password) async {
    final url = Uri.parse("$baseUrl/login");
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": email, "password": password}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return {"success": true, "token": data["token"]};
    } else {
      return {"success": false, "message": jsonDecode(response.body)["message"]};
    }
  }

  // Find User API
  Future<Map<String, dynamic>> findUser(String userId) async {
    final url = Uri.parse("$baseUrl/$userId");
    final response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return {"success": true, "name": data["name"]};
    } else {
      return {"success": false, "message": jsonDecode(response.body)["message"]};
    }
  }
}
