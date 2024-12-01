import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:stash_fund/components/ids.dart';

class StreakService {
  final String baseUrl = "${server_url}/api/streak"; // Replace with your backend URL

  // Get or Create Streak for a User
  Future<Map<String, dynamic>> getOrCreateStreak(String userId) async {
    final url = Uri.parse("$baseUrl/$userId");

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return {"success": true, "streak": data};
      } else {
        return {"success": false, "message": jsonDecode(response.body)["message"]};
      }
    } catch (error) {
      return {"success": false, "message": "Error retrieving or creating streak: $error"};
    }
  }

  // Update Streak for a User
  Future<Map<String, dynamic>> updateStreak(String userId) async {
    final url = Uri.parse("$baseUrl/$userId");

    try {
      final response = await http.put(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return {"success": true, "streak": data};
      } else {
        return {"success": false, "message": jsonDecode(response.body)["message"]};
      }
    } catch (error) {
      return {"success": false, "message": "Error updating streak: $error"};
    }
  }

  // Reset Streak for a User
  Future<Map<String, dynamic>> resetStreak(String userId) async {
    final url = Uri.parse("$baseUrl/$userId");

    try {
      final response = await http.delete(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return {"success": true, "streak": data};
      } else {
        return {"success": false, "message": jsonDecode(response.body)["message"]};
      }
    } catch (error) {
      return {"success": false, "message": "Error resetting streak: $error"};
    }
  }
}
