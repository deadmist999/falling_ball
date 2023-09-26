import 'package:falling_ball/screens/home_screen/home_screen.dart';
import 'package:flutter/material.dart';

class GameOverWidget extends StatelessWidget {
  final int points;
  final VoidCallback onGameRestarted;

  const GameOverWidget({
    super.key,
    required this.points,
    required this.onGameRestarted,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Text(
            'Game over!',
            style: TextStyle(
              fontSize: 32,
            ),
          ),
          Text("You have a score of $points points."),
          FilledButton(
            onPressed: () => onGameRestarted(),
            child: const Text("Try again"),
          ),
          FilledButton(
            onPressed: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => const HomeScreen(),
              ),
            ),
            child: const Text("Back to main menu"),
          ),
        ],
      ),
    );
  }
}
