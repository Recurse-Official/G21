import 'package:flutter/material.dart';

class CategoriesPage extends StatefulWidget {
  @override
  _CategoriesPageState createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  final Map<String, double> categoryGoals = {};

  final Map<String, IconData> categories = {
    'Dining Out': Icons.restaurant,
    'Shopping': Icons.shopping_cart,
    'Entertainment': Icons.music_video,
    'Movies': Icons.movie,
    'Vacation': Icons.flight,
    'Rent': Icons.home,
    'Food': Icons.fastfood,
    'Transportation': Icons.directions_bus,
    'Utilities': Icons.electric_bolt,
    'Insurance': Icons.security,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFE3F2FD),
        title: Text('Categories', style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: Container(
        color: Color(0xFFE3F2FD),
        child: Column(
          children: [
            SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  _buildCategorySection('Wants', [
                    'Dining Out',
                    'Shopping',
                    'Entertainment',
                    'Movies',
                    'Vacation',
                  ]),
                  _buildCategorySection('Needs', [
                    'Rent',
                    'Food',
                    'Transportation',
                    'Utilities',
                    'Insurance',
                  ]),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategorySection(String title, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
            title,
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
        Divider(color: Colors.grey),
        GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 1,
          ),
          itemCount: items.length,
          itemBuilder: (context, index) {
            final category = items[index];
            return GestureDetector(
              onTap: () {
                _showBottomSheet(context, category);
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 30,
                    child: Icon(categories[category], size: 30),
                  ),
                  SizedBox(height: 8),
                  Text(
                    category,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, color: Colors.black),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

 void _showBottomSheet(BuildContext context, String category) {
  TextEditingController amountController = TextEditingController();

  showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    isScrollControlled: true, // Allows the bottom sheet to resize with the keyboard
    builder: (BuildContext context) {
      return Padding(
        padding: EdgeInsets.only(
          left: 16.0,
          right: 16.0,
          bottom: MediaQuery.of(context).viewInsets.bottom, // Dynamic padding to accommodate the keyboard
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 16),
            Text(
              'Set Goal for $category',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Enter amount',
                prefixText: '₹ ',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: double.infinity, // Makes the button full-width
              height: 50, // Adjust the height as needed
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 12),
                ),
                onPressed: () {
                  if (amountController.text.isNotEmpty) {
                    final amount = double.tryParse(amountController.text);
                    if (amount != null) {
                      setState(() {
                        categoryGoals[category] = amount;
                      });
                      Navigator.pop(context);
                    }
                  }
                },
                child: Text('Save Goal', style: TextStyle(fontSize: 16)), // Adjust text size
              ),
            ),
            SizedBox(height: 16), // Add some space at the bottom
          ],
        ),
      );
    },
  );
}
}
