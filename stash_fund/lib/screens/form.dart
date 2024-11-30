import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Budget Form"),
        backgroundColor: Color(0xFFBDE0FE),
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
                _buildQuestionAndInput("How much do you spend daily on travel?"),
                _buildQuestionAndInput("How far do you travel daily?"),
                _buildQuestionAndInput("What are your weekly coffee expenses?"),
                _buildQuestionAndInput("What is the amount of your current bill?"),
                _buildQuestionAndInput("Can you describe your food habits?", multiline: true),
                _buildQuestionAndRadioGroup("What is your gender?", ["Male", "Female", "Other"], (value) {
                  setState(() {
                    gender = value;
                  });
                }),
                _buildQuestionAndInput("What is your weight (kg)?"),
                _buildQuestionAndInput("What is your height (cm)?"),
                _buildQuestionAndInput("What is your age?"),
                _buildQuestionAndInput("How do you feel about your financial situation?", multiline: true),
                _buildQuestionAndInput("Who do you typically spend money on besides yourself?", multiline: true),
                _buildQuestionAndInput("Can you describe your living conditions?", multiline: true),
                _buildQuestionAndRadioGroup("Do you have any debts?", ["Yes", "No"], (value) {
                  // Handle value change
                }),
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
                _buildQuestionAndInput("What do you want to include in your budget without stress?", multiline: true),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        _formKey.currentState!.reset();
                      },
                      child: Text("Cancel"),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue[900],
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Form Submitted")),
                          );
                        }
                      },
                      child: Text("Next"),
                    ),
                  ],
                )
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

  Widget _buildInputField({bool multiline = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0), // Adjust horizontal padding here
        child: TextFormField(
          maxLines: multiline ? 3 : 1,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
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
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: DropdownButtonFormField<String>(
        value: value,
        onChanged: onChanged,
        items: options
            .map((e) => DropdownMenuItem(value: e, child: Text(e)))
            .toList(),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
  Widget _buildQuestionAndInput(String question, {bool multiline = false}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10.0), // Symmetric horizontal padding
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildQuestion(question), // Question above
        _buildInputField(multiline: multiline), // Input field below
      ],
    ),
  );
}

Widget _buildQuestionAndRadioGroup(String question, List<String> options, Function(String?) onChanged) {
  return Padding(
    padding: const EdgeInsets.only(left: 16.0, bottom: 16.0), // Left and bottom padding
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildQuestion(question), // Question above
        ...options.map((option) {
          return RadioListTile<String>(
            title: Text(option),
            value: option,
            groupValue: gender,
            onChanged: onChanged,
          );
        }).toList(), // Radio options below
      ],
    ),
  );
}

Widget _buildQuestionAndCheckboxGroup(String question, List<String> options, List<String> selected) {
  return Padding(
    padding: const EdgeInsets.only(left: 16.0, bottom: 16.0), // Left and bottom padding
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildQuestion(question), // Question above
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
        }).toList(), // Checkbox options below
      ],
    ),
  );
}

Widget _buildQuestionAndDropdown(String question, List<String> options, Function(String?) onChanged, String? value) {
  return Padding(
    padding: const EdgeInsets.only(left: 16.0, bottom: 16.0), // Left and bottom padding
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildQuestion(question), // Question above
        DropdownButtonFormField<String>(
          value: value,
          onChanged: onChanged,
          items: options
              .map((e) => DropdownMenuItem(value: e, child: Text(e)))
              .toList(),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ), // Dropdown field below
      ],
    ),
  );
}



}
