import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:stash_fund/components/ids.dart';

class GroupVaultService {
  final String baseUrl = "${server_url}/api/groupVault"; // Replace with your backend URL

  // Chip in to a group vault
  Future<Map<String, dynamic>> chipIn(String groupId, String userId, double amount, String source) async {
    final url = Uri.parse("$baseUrl/chipIn");

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "groupId": groupId,
          "userId": userId,
          "amount": amount,
          "source": source
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return {"success": true, "contributions": data["contributions"]};
      } else {
        return {"success": false, "message": jsonDecode(response.body)["message"]};
      }
    } catch (error) {
      return {"success": false, "message": "Error while chipping in: $error"};
    }
  }

  // Chip out from a group vault
  Future<Map<String, dynamic>> chipOut(String groupId, String userId, double amount) async {
    final url = Uri.parse("$baseUrl/chipOut");

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "groupId": groupId,
          "userId": userId,
          "amount": amount,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return {
          "success": true,
          "groupVault": data["groupVault"],
          "personalVault": data["personalVault"]
        };
      } else {
        return {"success": false, "message": jsonDecode(response.body)["message"]};
      }
    } catch (error) {
      return {"success": false, "message": "Error while chipping out: $error"};
    }
  }

  // Create a new group vault
  Future<Map<String, dynamic>> createGroupVault(String name, String purpose) async {
    final url = Uri.parse("$baseUrl/create");

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "name": name,
          "purpose": purpose,
        }),
      );

      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        return {"success": true, "groupVault": data["groupVault"]};
      } else {
        return {"success": false, "message": jsonDecode(response.body)["message"]};
      }
    } catch (error) {
      return {"success": false, "message": "Error while creating group vault: $error"};
    }
  }

  // Get group vault details
  Future<Map<String, dynamic>> getGroupVaultDetails(String groupId) async {
    final url = Uri.parse("$baseUrl/details/$groupId");

    try {
      final response = await http.get(
        url,
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return {"success": true, "groupVault": data["groupVault"]};
      } else {
        return {"success": false, "message": jsonDecode(response.body)["message"]};
      }
    } catch (error) {
      return {"success": false, "message": "Error fetching group vault details: $error"};
    }
  }
}
