import 'package:flutter/material.dart';

class PayScreen extends StatefulWidget {
  @override
  _PayScreenState createState() => _PayScreenState();
}

class _PayScreenState extends State<PayScreen> {
  String? selectedCategory; // To store the selected category
  TextEditingController amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pay'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Select Category',
              style: TextStyle(fontSize: 16),
            ),
            DropdownButton<String>(
              isExpanded: true,
              value: selectedCategory,
              hint: Text('Choose a category'),
              items: [
                'Dining Out',
                'Shopping',
                'Entertainment',
                'Movies',
                'Vacation',
                'Rent',
                'Food',
                'Transportation',
                'Utilities',
                'Insurance',
              ].map((category) {
                return DropdownMenuItem<String>(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedCategory = value; // Update selected category
                });
              },
            ),
            SizedBox(height: 16),
            Text(
              'Enter Amount',
              style: TextStyle(fontSize: 16),
            ),
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter amount',
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  String category = selectedCategory ?? 'No category selected';
                  String amount = amountController.text;

                  // Navigate to the QRScan screen
                  Navigator.pushNamed(
                    context,
                    '/qrscan',
                    arguments: {'category': category, 'amount': amount}, // Pass data if needed
                  );
                },
                child: Text('Pay'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
