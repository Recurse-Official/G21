import 'package:flutter/material.dart';

class SavingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Savings'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Savings Timeline'),
            SizedBox(height: 20),
            TimelineItem(title: 'January', description: 'Saved \$100'),
            TimelineItem(title: 'February', description: 'Saved \$150'),
            TimelineItem(title: 'March', description: 'Saved \$200'),
          ],
        ),
      ),
    );
  }
}

class TimelineItem extends StatelessWidget {
  final String title;
  final String description;

  TimelineItem({required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        Text(description),
        SizedBox(height: 10),
      ],
    );
  }
}