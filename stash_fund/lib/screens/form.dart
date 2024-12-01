import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:stash_fund/services/formService.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Arial'),
      home: BudgetForm(),
    );
  }
}

class BudgetForm extends StatefulWidget {
  @override
  _BudgetFormState createState() => _BudgetFormState();
}

class _BudgetFormState extends State<BudgetForm> {
  final _formKey = GlobalKey<FormState>();
  String? gender;
  String? savingGoal;
  List<String> regularExpenses = [];
  List<String> unexpectedExpenses = [];
  int? dailyTravelExpenses;
  int? weeklyCoffeeExpenses;
  String? foodHabits;
  int? currentBill;
  int? weight;
  int? height;
  int? age;
  String? financialFeelings;
  String? spendingOnOthers;
  String? livingConditions;
  String? hasDebts;
  String? stressFreeBudgetItems;

  final formService = BudgetFormService();

  // Controllers
  final TextEditingController dailyTravelController = TextEditingController();
  final TextEditingController weeklyCoffeeController = TextEditingController();
  final TextEditingController foodHabitsController = TextEditingController();
  final TextEditingController currentBillController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController financialFeelingsController = TextEditingController();
  final TextEditingController spendingOnOthersController = TextEditingController();
  final TextEditingController livingConditionsController = TextEditingController();
  final TextEditingController stressFreeItemsController = TextEditingController();

  @override
  void dispose() {
    // Dispose controllers
    dailyTravelController.dispose();
    weeklyCoffeeController.dispose();
    foodHabitsController.dispose();
    currentBillController.dispose();
    weightController.dispose();
    heightController.dispose();
    ageController.dispose();
    financialFeelingsController.dispose();
    spendingOnOthersController.dispose();
    livingConditionsController.dispose();
    stressFreeItemsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Budget Form"),
        backgroundColor: Color(0xFFBDE0FE),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Color(0xFFBDE0FE), // Light blue background
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildQuestionAndInput(
                  "How much do you spend daily on travel?",
                  dailyTravelController,
                ),
                _buildQuestionAndInput(
                  "What are your weekly coffee expenses?",
                  weeklyCoffeeController,
                ),
                _buildQuestionAndInput(
                  "What is the amount of your current bill?",
                  currentBillController,
                ),
                _buildQuestionAndInput(
                  "Can you describe your food habits?",
                  foodHabitsController,
                  multiline: true,
                ),
                _buildQuestionAndRadioGroup(
                  "What is your gender?",
                  ["Male", "Female", "Other"],
                  (value) {
                    setState(() {
                      gender = value;
                    });
                  },
                  gender,
                ),
                _buildQuestionAndInput("What is your weight (kg)?", weightController),
                _buildQuestionAndInput("What is your height (cm)?", heightController),
                _buildQuestionAndInput("What is your age?", ageController),
                _buildQuestionAndInput(
                  "How do you feel about your financial situation?",
                  financialFeelingsController,
                  multiline: true,
                ),
                _buildQuestionAndInput(
                  "Who do you typically spend money on besides yourself?",
                  spendingOnOthersController,
                  multiline: true,
                ),
                _buildQuestionAndInput(
                  "Can you describe your living conditions?",
                  livingConditionsController,
                  multiline: true,
                ),
               _buildQuestionAndRadioGroup(
                  "Do you have any debts?",
                  ["Yes", "No"],
                  (value) {
                    setState(() {
                      hasDebts = value;
                    });
                  },
                    hasDebts,
                ),

                _buildQuestionAndCheckboxGroup(
                  "Which of these do you regularly spend on?",
                  ["Music", "Streaming Services", "Food", "Fitness"],
                  regularExpenses,
                ),
                _buildQuestionAndCheckboxGroup(
                  "What expenses often catch you off guard?",
                  ["Credit Card Bills", "Medical Costs", "Taxes", "Vehicle Expenses"],
                  unexpectedExpenses,
                ),
                _buildQuestionAndDropdown(
                  "What are you currently saving for?",
                  ["College", "Vacations", "A House", "General Savings"],
                  (value) {
                    setState(() {
                      savingGoal = value;
                    });
                  },
                  savingGoal,
                ),
                _buildQuestionAndInput(
                  "What do you want to include in your budget without stress?",
                  stressFreeItemsController,
                  multiline: true,
                ),
                SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[900],
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () async {
                    // Collect all form data
                    String errorMessage = "";

                    if (gender == null || gender!.isEmpty) {
                      errorMessage += "Gender is required.\n";
                    }
                    if (savingGoal == null || savingGoal!.isEmpty) {
                      errorMessage += "Saving goal is required.\n";
                    }
                    if (dailyTravelController.text.isEmpty || int.tryParse(dailyTravelController.text) == null) {
                      errorMessage += "Please provide a valid daily travel expense.\n";
                    }
                    if (weeklyCoffeeController.text.isEmpty || int.tryParse(weeklyCoffeeController.text) == null) {
                      errorMessage += "Please provide a valid weekly coffee expense.\n";
                    }
                    if (foodHabitsController.text.isEmpty) {
                      errorMessage += "Food habits are required.\n";
                    }
                    if (weightController.text.isEmpty || int.tryParse(weightController.text) == null) {
                      errorMessage += "Please provide a valid weight.\n";
                    }
                    if (heightController.text.isEmpty || int.tryParse(heightController.text) == null) {
                      errorMessage += "Please provide a valid height.\n";
                    }
                    if (ageController.text.isEmpty || int.tryParse(ageController.text) == null) {
                      errorMessage += "Please provide a valid age.\n";
                    }

                    // Check if there are any errors
                    if (errorMessage.isNotEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(errorMessage)),
                      );
                      return;
                    }
                    print("No errors");
                    // If no errors, prepare data and submit
                   Map<String, dynamic> formData = {
                      "userId": "some_user_id", // Replace this with the actual user ID from your app context
                      "gender": gender,
                      "savingGoal": savingGoal,
                      "regularExpenses": regularExpenses,
                      "unexpectedExpenses": unexpectedExpenses,
                      "dailyTravelExpenses": int.tryParse(dailyTravelController.text),
                      "weeklyCoffeeExpenses": int.tryParse(weeklyCoffeeController.text),
                      "foodHabits": foodHabitsController.text,
                      "currentBill": currentBillController.text.isNotEmpty
                          ? int.tryParse(currentBillController.text)
                          : null,
                      "weight": weightController.text.isNotEmpty
                          ? int.tryParse(weightController.text)
                          : null,
                      "height": heightController.text.isNotEmpty
                          ? int.tryParse(heightController.text)
                          : null,
                      "age": ageController.text.isNotEmpty
                          ? int.tryParse(ageController.text)
                          : null,
                      "financialFeelings": financialFeelingsController.text.isNotEmpty
                          ? financialFeelingsController.text
                          : null,
                      "spendingOnOthers": spendingOnOthersController.text.isNotEmpty
                          ? spendingOnOthersController.text
                          : null,
                      "livingConditions": livingConditionsController.text.isNotEmpty
                          ? livingConditionsController.text
                          : null,
                      "hasDebts": hasDebts,
                      "stressFreeBudgetItems": stressFreeItemsController.text.isNotEmpty
                          ? stressFreeItemsController.text
                          : null,
                    };


                    var response = await formService.submitBudgetForm(formData);

                    if (response['success']) {
                      Navigator.pushReplacementNamed(context, '/home');
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(response['message'])),
                      );
                    }
                  },

                    child: Text("Submit"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQuestion(String question) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, bottom: 8.0),
      child: Text(
        question,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
    );
  }

  Widget _buildInputField(
    TextEditingController controller, {
    bool multiline = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        controller: controller,
        maxLines: multiline ? 3 : 1,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "This field cannot be empty";
          }
          return null;
        },
      ),
    );
  }

  Widget _buildRadioGroup(List<String> options, Function(String?) onChanged, String? groupValue) {
    return Column(
      children: options.map((option) {
        return RadioListTile<String>(
          title: Text(option),
          value: option,
          groupValue: groupValue,
          onChanged: onChanged,
        );
      }).toList(),
    );
  }

  Widget _buildCheckboxGroup(List<String> options, List<String> selected) {
    return Column(
      children: options.map((option) {
        return CheckboxListTile(
          title: Text(option),
          value: selected.contains(option),
          onChanged: (val) {
            setState(() {
              val! ? selected.add(option) : selected.remove(option);
            });
          },
          controlAffinity: ListTileControlAffinity.leading,
        );
      }).toList(),
    );
  }

  Widget _buildDropdownField(List<String> options, Function(String?) onChanged, String? value) {
    return DropdownButtonFormField<String>(
      value: value,
      onChanged: onChanged,
      items: options.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  Widget _buildQuestionAndInput(String question, TextEditingController controller, {bool multiline = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildQuestion(question),
          _buildInputField(controller, multiline: multiline),
        ],
      ),
    );
  }
  Widget _buildQuestionAndRadioGroup(String question, List<String> options, Function(String?) onChanged, String? groupValue) {
  return Padding(
    padding: const EdgeInsets.only(left: 16.0, bottom: 16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildQuestion(question),
        ...options.map((option) {
          return RadioListTile<String>(
            title: Text(option),
            value: option,
            groupValue: groupValue,
            onChanged: onChanged,
          );
        }).toList(),
      ],
    ),
  );
}

  // Widget _buildQuestionAndRadioGroup(String question, List<String> options, Function(String?) onChanged) {
  //   return Padding(
  //     padding: const EdgeInsets.only(left: 16.0, bottom: 16.0),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         _buildQuestion(question),
  //         ...options.map((option) {
  //           return RadioListTile<String>(
  //             title: Text(option),
  //             value: option,
  //             groupValue: gender,
  //             onChanged: onChanged,
  //           );
  //         }).toList(),
  //       ],
  //     ),
  //   );
  // }

  Widget _buildQuestionAndCheckboxGroup(String question, List<String> options, List<String> selected) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildQuestion(question),
          ...options.map((option) {
            return CheckboxListTile(
              title: Text(option),
              value: selected.contains(option),
              onChanged: (val) {
                setState(() {
                  val! ? selected.add(option) : selected.remove(option);
                });
              },
              controlAffinity: ListTileControlAffinity.leading,
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildQuestionAndDropdown(String question, List<String> options, Function(String?) onChanged, String? value) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildQuestion(question),
          _buildDropdownField(options, onChanged, value),
        ],
      ),
    );
  }
}
