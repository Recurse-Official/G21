// import 'package:flutter/material.dart';

// class SavingsScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Savings'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text('Savings Timeline'),
//             SizedBox(height: 20),
//             TimelineItem(title: 'January', description: 'Saved \$100'),
//             TimelineItem(title: 'February', description: 'Saved \$150'),
//             TimelineItem(title: 'March', description: 'Saved \$200'),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class TimelineItem extends StatelessWidget {
//   final String title;
//   final String description;

//   TimelineItem({required this.title, required this.description});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Text(
//           title,
//           style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
//         ),
//         Text(description),
//         SizedBox(height: 10),
//       ],
//     );
//   }
// }
import 'package:flutter/material.dart';
import '../components/savings_chart.dart'; // Import the refactored component

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
