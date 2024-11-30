import 'package:flutter/material.dart';

class SetUpGoalPage extends StatefulWidget {
  final String category;

  const SetUpGoalPage({Key? key, required this.category}) : super(key: key);

  @override
  _SetUpGoalPageState createState() => _SetUpGoalPageState();
}

class _SetUpGoalPageState extends State<SetUpGoalPage> {
  final TextEditingController _amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFE3F2FD),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Set up Goal', style: TextStyle(color: Colors.black)),
      ),
      body: Container(
        color: Color(0xFFE3F2FD),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                widget.category,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30),
              TextField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Amount',
                  prefixText: '₹ ',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueGrey[900],
                  padding: EdgeInsets.symmetric(vertical: 12),
                ),
                onPressed: () {
                  if (_amountController.text.isNotEmpty) {
                    final amount = double.tryParse(_amountController.text);
                    if (amount != null) {
                      Navigator.pop(context, amount);
                    }
                  }
                },
                child: Text('Add Transaction'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
