import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:stash_fund/components/ids.dart';

class GeminiService {
  final String baseUrl = "${server_url}/api/gemini"; // Replace with your actual backend URL

  // Generate content based on a prompt
  Future<Map<String, dynamic>> generateContent(String prompt) async {
    final url = Uri.parse("$baseUrl/generate");

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        //TODO: add prompt template here using stored details
        body: jsonEncode({"prompt": prompt}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return {"success": true, "data": data};
      } else {
        return {"success": false, "message": jsonDecode(response.body)["error"]};
      }
    } catch (error) {
      return {"success": false, "message": "Error generating content: $error"};
    }
  }
}
