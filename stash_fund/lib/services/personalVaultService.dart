import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:stash_fund/components/ids.dart';

class PersonalVaultService {
  final String baseUrl = "${server_url}/api/personalVault"; // Replace with your backend URL

  // Chip in to the personal vault
  Future<Map<String, dynamic>> chipIn(String userId, double amount) async {
    final url = Uri.parse("$baseUrl/chipIn");

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "userId": userId,
          "amount": amount,
        }), 
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return {"success": true, "vault": data["vault"]};
      } else {
        return {"success": false, "message": jsonDecode(response.body)["message"]};
      }
    } catch (error) {
      return {"success": false, "message": "Error while chipping in: $error"};
    }
  }

  // Chip out from the personal vault
  Future<Map<String, dynamic>> chipOut(String userId, double amount) async {
    final url = Uri.parse("$baseUrl/chipOut");

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "userId": userId,
          "amount": amount,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return {"success": true, "vault": data["vault"]};
      } else {
        return {"success": false, "message": jsonDecode(response.body)["message"]};
      }
    } catch (error) {
      return {"success": false, "message": "Error while chipping out: $error"};
    }
  }

  // Get personal vault details
  Future<Map<String, dynamic>> getVaultDetails(String userId) async {
    final url = Uri.parse("$baseUrl/details/$userId");

    try {
      final response = await http.get(
        url,
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return {"success": true, "vault": data["vault"]};
      } else {
        return {"success": false, "message": jsonDecode(response.body)["message"]};
      }
    } catch (error) {
      return {"success": false, "message": "Error fetching vault details: $error"};
    }
  }
}
