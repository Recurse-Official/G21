import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:stash_fund/components/ids.dart';

class BudgetFormService {
  final String baseUrl = "${server_url}/api/budgetForm"; // Replace with your actual backend URL

  // Submit Budget Form
  Future<Map<String, dynamic>> submitBudgetForm(Map<String, dynamic> formData) async {
    final url = Uri.parse("$baseUrl/submit");
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(formData),
    );

    if (response.statusCode == 201) {
      return {"success": true, "message": jsonDecode(response.body)["message"]};
    } else {
      return {"success": false, "message": jsonDecode(response.body)["error"]};
    }
  }

  // Get Budget Form Data
  Future<Map<String, dynamic>> getBudgetFormData(String userId) async {
    final url = Uri.parse("$baseUrl/$userId");
    final response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return {"success": true, "formData": data};
    } else {
      return {"success": false, "message": jsonDecode(response.body)["error"]};
    }
  }
}
