// import 'package:flutter/material.dart';
// import 'package:gradient_circular_progress_indicator/gradient_circular_progress_indicator.dart';

// class SavingsChart extends StatefulWidget {
//   @override
//   _SavingsChartState createState() => _SavingsChartState();
// }

// class _SavingsChartState extends State<SavingsChart>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _animationController;

//   @override
//   void initState() {
//     super.initState();
//     _animationController = AnimationController(
//       vsync: this,
//       duration: Duration(seconds: 1), // Total animation duration
//     )..forward(); // Start the animation
//   }

//   @override
//   void dispose() {
//     _animationController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Savings Progress")),
//       body: Center(
//         child: ConcentricGradientProgress(animationController: _animationController),
//       ),
//     );
//   }
// }

// class ConcentricGradientProgress extends StatelessWidget {
//   final AnimationController animationController;

//   ConcentricGradientProgress({required this.animationController});

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       alignment: Alignment.center,
//       children: [
//         _buildConcentricCircle(
//           progress: 0.25,
//           gradient: LinearGradient(
//             colors: [Colors.blue, Colors.green],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//           size: 300.0,
//           stroke: 12.0,
//         ),
//         _buildConcentricCircle(
//           progress: 0.5,
//           gradient: LinearGradient(
//             colors: [Colors.red, Colors.orange],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//           size: 250.0,
//           stroke: 12.0,
//         ),
//         _buildConcentricCircle(
//           progress: 0.75,
//           gradient: LinearGradient(
//             colors: [Colors.purple, Colors.pink],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//           size: 200.0,
//           stroke: 12.0,
//         ),
//         _buildConcentricCircle(
//           progress: 0.9,
//           gradient: LinearGradient(
//             colors: [Colors.yellow, Colors.greenAccent],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//           size: 150.0,
//           stroke: 12.0,
//         ),
//       ],
//     );
//   }

//   Widget _buildConcentricCircle({
//     required double progress,
//     required LinearGradient gradient,
//     required double size,
//     required double stroke,
//   }) {
//     return TweenAnimationBuilder<double>(
//       tween: Tween(begin: 0.0, end: progress), // Start from 0 and animate to `progress`
//       duration: Duration(seconds: 1),
//       builder: (context, animatedProgress, _) {
//         return GradientCircularProgressIndicator(
//           progress: animatedProgress, // Use the animated progress value
//           gradient: gradient,
//           backgroundColor: Colors.grey,
//           size: size,
//           stroke: stroke,
//         );
//       },
//       curve: Curves.easeInOut, // Smooth animation curve
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:gradient_circular_progress_indicator/gradient_circular_progress_indicator.dart';

class SavingsChart extends StatelessWidget {
  final List<CircleConfig> circles;

  const SavingsChart({
    Key? key,
    required this.circles,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: circles.map((circle) => _buildConcentricCircle(circle)).toList(),
    );
  }

  Widget _buildConcentricCircle(CircleConfig config) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: config.progress),
      duration: Duration(seconds: 1),
      builder: (context, animatedProgress, _) {
        return GradientCircularProgressIndicator(
          progress: animatedProgress,
          gradient: config.gradient,
          backgroundColor: Colors.grey,
          size: config.size,
          stroke: config.stroke,
        );
      },
      curve: Curves.easeInOut,
    );
  }
}

class CircleConfig {
  final double progress;
  final LinearGradient gradient;
  final double size;
  final double stroke;

  CircleConfig({
    required this.progress,
    required this.gradient,
    required this.size,
    required this.stroke,
  });
}
