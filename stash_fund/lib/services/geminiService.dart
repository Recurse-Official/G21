import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stash_fund/components/ids.dart';
import 'package:stash_fund/services/formService.dart';
import 'package:stash_fund/services/goalService.dart';
import 'package:stash_fund/services/streakService.dart';

class GeminiService {
  final String baseUrl = "${server_url}/api/gemini";
  final BudgetFormService budgetFormService = BudgetFormService();
  final StreakService streakService = StreakService();
  final GoalService goalService = GoalService();

  Future<Map<String, dynamic>> generateContent(
      String userId, String category, String promptType) async {
    final url = Uri.parse("$baseUrl/generate");

    try {
      // Fetch data from services
      final budgetData = await budgetFormService.getBudgetFormData(userId);
      final streakData = await streakService.getOrCreateStreak(userId);
      final goalsData = await goalService.getGoals(userId);

      if (!budgetData['success'] || !streakData['success'] || !goalsData['success']) {
        return {
          "success": false,
          "message": "Failed to retrieve data: Ensure all services are returning data correctly."
        };
      }

      // Extract details
      final budgetForm = budgetData['formData'][0];
      final streak = streakData['streak'];
      final goals = goalsData['goals'];

      final userName = budgetForm['userName'] ?? "User";

      // Extract goal details for the given category
      final goal = goals.firstWhere(
        (goal) => goal['type'] == category,
        orElse: () => {"targetAmount": 0, "spentAmount": 0},
      );

      // Safely parse numeric values
      final currentSpending = double.tryParse(goal['spentAmount']?.toString() ?? '0') ?? 0.0;
      final spendingLimit = double.tryParse(goal['targetAmount']?.toString() ?? '0') ?? 0.0;
      final utilizationRatio = spendingLimit > 0.0 ? (currentSpending / spendingLimit) * 100 : 0.0;
      final dailyTravelExpenses = double.tryParse(budgetForm['dailyTravelExpenses']?.toString() ?? '0') ?? 0.0;
      final dailyCoffeeCharges = double.tryParse(budgetForm['weeklyCoffeeExpenses']?.toString() ?? '0') ?? 0.0 / 7;
      final foodHabits = budgetForm['foodHabits'] ?? "Not specified";
      final maxStreak = (streak['maxStreak'] as num?)?.toInt() ?? 0;
      final badges = List<String>.from(streak['badges'] ?? []);

      // Retrieve cumulative data if needed
      final cumulativePercentages = promptType == "cumulative"
          ? await getCumulativePercentages(category)
          : [0.0];

      // Build the prompt based on the selected type
      final prompt = promptType == "alert"
          ? buildImpulseAlertPrompt(
              userName: userName,
              category: category,
              currentSpending: currentSpending,
              spendingLimit: spendingLimit,
              utilizationRatio: utilizationRatio,
              dailyTravelExpenses: dailyTravelExpenses,
              dailyCoffeeCharges: dailyCoffeeCharges,
              foodHabits: foodHabits,
              maxStreak: maxStreak,
              badges: badges,
            )
          : buildCumulativePrompt(
              userName: userName,
              category: category,
              currentSpending: currentSpending,
              spendingLimit: spendingLimit,
              utilizationRatio: utilizationRatio,
              dailyTravelExpenses: dailyTravelExpenses,
              dailyCoffeeCharges: dailyCoffeeCharges,
              foodHabits: foodHabits,
              maxStreak: maxStreak,
              badges: badges,
              cumulativePercentages: cumulativePercentages,
            );

      // Send request to Gemini API
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"prompt": prompt}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print(data);
        return {"success": true, "data": data};
      } else {
        final error = jsonDecode(response.body)['error'];
        return {"success": false, "message": "Gemini API error: $error"};
      }
    } catch (error) {
      return {"success": false, "message": "Error generating content: $error"};
    }
  }

  // Alert Prompt Template
  String buildImpulseAlertPrompt({
    required String userName,
    required String category,
    required double currentSpending,
    required double spendingLimit,
    required double utilizationRatio,
    required double dailyTravelExpenses,
    required double dailyCoffeeCharges,
    required String foodHabits,
    required int maxStreak,
    required List<String> badges,
  }) {
    final String badgeList = badges.isNotEmpty ? badges.join(", ") : "No badges";

    return """
You are a financial assistant providing personalized impulse alerts for users based on their spending habits and behavioral traits. Use the following structured input to craft an engaging and personalized response.

### Input Details:
1. **Spending Details**:
   - **Category**: $category
   - **Current Spending**: \$${currentSpending.toStringAsFixed(2)}
   - **Spending Limit**: \$${spendingLimit.toStringAsFixed(2)}
   - **Utilization Ratio**: ${utilizationRatio.toStringAsFixed(2)}%

2. **User Profile**:
   - **Daily Travel Expenses**: \$${dailyTravelExpenses.toStringAsFixed(2)}
   - **Daily Coffee Charges**: \$${dailyCoffeeCharges.toStringAsFixed(2)}
   - **Food Habits**: $foodHabits

3. **Behavioral Traits**:
   - **Max Streak**: $maxStreak days
   - **Badges Earned**: $badgeList

### Response Goals:
- Warn the user about their spending in the specified category.
- Mention how much of their limit has been used and how it compares to their past behavior.
- Incorporate streaks and badges to personalize the tone, encouraging positive financial habits.
- Offer actionable suggestions (e.g., review spending, adjust limits, or reconsider the purchase).
- Limit the response to a maximum of 3-4 sentences.
""";
  }

  // Cumulative Data Prompt Template
  String buildCumulativePrompt({
    required String userName,
    required String category,
    required double currentSpending,
    required double spendingLimit,
    required double utilizationRatio,
    required double dailyTravelExpenses,
    required double dailyCoffeeCharges,
    required String foodHabits,
    required int maxStreak,
    required List<String> badges,
    required List<double> cumulativePercentages,
  }) {
    final String historicalData = cumulativePercentages.isNotEmpty
        ? cumulativePercentages.map((e) => e.toStringAsFixed(2)).join(", ")
        : "No previous data available";

    return """
You are a financial assistant providing personalized impulse alerts for users based on their spending habits and behavioral traits. Use the following structured input to craft an engaging and personalized question to better understand the user and improve future alerts.

### Input Details:
1. **Spending Details**:
   - **Category**: $category
   - **Current Spending**: \$${currentSpending.toStringAsFixed(2)}
   - **Spending Limit**: \$${spendingLimit.toStringAsFixed(2)}
   - **Utilization Ratio**: ${utilizationRatio.toStringAsFixed(2)}%

2. **User Profile**:
   - **Daily Travel Expenses**: \$${dailyTravelExpenses.toStringAsFixed(2)}
   - **Daily Coffee Charges**: \$${dailyCoffeeCharges.toStringAsFixed(2)}
   - **Food Habits**: $foodHabits

3. **Behavioral Traits**:
   - **Max Streak**: $maxStreak days
   - **Badges Earned**: ${badges.join(", ")}

4. **Previously Stored Data**:
   - **Historical Percentages for $category**: $historicalData

### Response Goals:
- It should ask user a question to understand their spending behavior over time.
- Reference the user's current spending and past behavior to provide context.
- Make the question engaging and encourage the user to understand on their spending habits.
- Limit the response to a maximum of 1-2 sentences.
""";
  }

  // Add new percentage to cumulative data
  Future<void> addPercentageToHistory(String category, double percentage) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'cumulative_$category';
    final List<String> history = prefs.getStringList(key) ?? [];
    history.add(percentage.toString());
    await prefs.setStringList(key, history);
  }

  // Fetch cumulative percentages from shared preferences
  Future<List<double>> getCumulativePercentages(String category) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'cumulative_$category';
    final List<String> history = prefs.getStringList(key) ?? [];
    return history.map((e) => double.tryParse(e) ?? 0.0).toList().cast<double>();
  }
}
