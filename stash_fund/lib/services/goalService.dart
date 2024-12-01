import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:stash_fund/components/ids.dart';

class GoalService {
  final String baseUrl = "${server_url}/api/goal"; // Replace with your backend URL

  // Add a new goal
  Future<Map<String, dynamic>> addGoal(String type, double targetAmount, String userId) async {
    final url = Uri.parse("$baseUrl/addGoal");

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"type": type, "targetAmount": targetAmount, "userId": userId}),
      );

      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        return {"success": true, "goal": data["goal"]};
      } else {
        return {"success": false, "message": jsonDecode(response.body)["message"]};
      }
    } catch (error) {
      return {"success": false, "message": "Error adding goal: $error"};
    }
  }

  // Get all goals for a user
  Future<Map<String, dynamic>> getGoals(String userId) async {
    final url = Uri.parse("$baseUrl/$userId");

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return {"success": true, "goals": data};
      } else {
        return {"success": false, "message": jsonDecode(response.body)["message"]};
      }
    } catch (error) {
      return {"success": false, "message": "Error fetching goals: $error"};
    }
  }

  // Update spent amount for a goal
  Future<Map<String, dynamic>> updateSpentAmount(String type, double spentAmount, String userId) async {
    final url = Uri.parse("$baseUrl/updateSpent");

    try {
      final response = await http.put(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"type": type, "spentAmount": spentAmount, "userId": userId}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return {"success": true, "goal": data["goal"]};
      } else {
        return {"success": false, "message": jsonDecode(response.body)["message"]};
      }
    } catch (error) {
      return {"success": false, "message": "Error updating spent amount: $error"};
    }
  }

  // Update a goal's target amount
  Future<Map<String, dynamic>> updateGoal(String type, double targetAmount, String userId) async {
    final url = Uri.parse("$baseUrl/update");

    try {
      final response = await http.put(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"type": type, "targetAmount": targetAmount, "userId": userId}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return {"success": true, "goal": data["goal"]};
      } else {
        return {"success": false, "message": jsonDecode(response.body)["message"]};
      }
    } catch (error) {
      return {"success": false, "message": "Error updating goal: $error"};
    }
  }

  // Delete a goal
  Future<Map<String, dynamic>> deleteGoal(String type, String userId) async {
    final url = Uri.parse("$baseUrl/delete");

    try {
      final response = await http.delete(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"type": type, "userId": userId}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return {"success": true, "deletedGoal": data["deletedGoal"]};
      } else {
        return {"success": false, "message": jsonDecode(response.body)["message"]};
      }
    } catch (error) {
      return {"success": false, "message": "Error deleting goal: $error"};
    }
  }
}
