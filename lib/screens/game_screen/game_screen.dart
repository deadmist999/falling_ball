import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flame_audio/flame_audio.dart';

import 'package:falling_ball/game_cubit/game_cubit.dart';
import 'components/game_over_widget.dart';
import 'package:falling_ball/utils/app_dimensions.dart';
import 'package:falling_ball/utils/constants.dart';

class GameScreen extends StatefulWidget {

  const GameScreen({Key? key}) : super(key: key);

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late GameCubit gameCubit;

  @override
  void initState() {
    super.initState();
    gameCubit = context.read<GameCubit>();
  }

  @override
  Widget build(BuildContext context) {
    gameCubit.startGame();
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            FlameAudio.play("jump-sound.mp3").whenComplete(() => print('played'));
            gameCubit.onTapScreen();
          },
          child: BlocBuilder<GameCubit, GameState>(
            builder: (context, state) {
              if (state.isGameOver) {
                Future.delayed(Duration.zero, () {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content: GameOverWidget(
                          points: state.points,
                          onGameRestarted: () {
                            gameCubit.restartGame();
                            Navigator.of(context).pop();
                          },
                        ),
                      );
                    },
                  );
                });
              }
              return Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      Constants.footballFieldAsset,
                    ),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      left: AppDimensions.size(context).width / 2 - 25,
                      top: state.ballY,
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(Constants.ballAsset),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 20,
                      right: 20,
                      child: Text(
                        "Points: ${state.points}",
                        style: const TextStyle(
                          fontSize: 32,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
