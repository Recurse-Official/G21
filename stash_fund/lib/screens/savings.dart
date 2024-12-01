import 'package:flutter/material.dart';
import 'package:stash_fund/components/savings_chart.dart';

class SavingsPage extends StatelessWidget {
  const SavingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home Page")),
      body: Center(
        child: SavingsChart(
          circles: [
            CircleConfig(
              progress: 0.25,
              gradient: const LinearGradient(
                colors: [Colors.blue, Colors.green],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              size: 300.0,
              stroke: 12.0,
            ),
            CircleConfig(
              progress: 0.5,
              gradient: const LinearGradient(
                colors: [Colors.red, Colors.orange],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              size: 250.0,
              stroke: 12.0,
            ),
            CircleConfig(
              progress: 0.75,
              gradient: const LinearGradient(
                colors: [Colors.purple, Colors.pink],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              size: 200.0,
              stroke: 12.0,
            ),
            CircleConfig(
              progress: 0.9,
              gradient: const LinearGradient(
                colors: [Colors.yellow, Colors.greenAccent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              size: 150.0,
              stroke: 12.0,
            ),
          ],
        ),
      ),
    );
  }
}
