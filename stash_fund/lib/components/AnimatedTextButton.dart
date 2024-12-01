import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class AnimatedTextButton extends StatelessWidget {
  final String text;
  final String route;

  const AnimatedTextButton({
    Key? key,
    required this.text,
    required this.route,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        color: Colors.transparent, // Ensures tappable area
        child: AnimatedTextKit(
          animatedTexts: [
            TyperAnimatedText(
              text,
              textStyle: TextStyle(fontSize: 15, color: Colors.black),
              speed: const Duration(milliseconds: 100),
            ),
          ],
          isRepeatingAnimation: false, // Ensure it doesn't repeat
          onTap: () {
            Navigator.pushNamed(context, route);
          },
        ),
      ),
    );
  }
}
