import 'package:falling_ball/screens/game_screen/game_screen.dart';
import 'package:falling_ball/utils/app_dimensions.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Falling Ball"),
      ),
      body: Center(
        child: FilledButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => const GameScreen(),
              ),
            );
          },
          child: const Text("Start the game"),
        ),
      ),
    );
  }
}
