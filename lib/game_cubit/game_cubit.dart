import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:falling_ball/utils/constants.dart';

part 'game_state.dart';

class GameCubit extends Cubit<GameState> {
  late Timer _timer;
  final double screenHeight;

  bool _isTimerInitialized = false;

  GameCubit({required this.screenHeight}) : super(GameState());

  void onTapScreen() => _changeBallDirectionAndSpeed();

  void _endGame() {
    if (_isTimerInitialized) {
      _timer.cancel();
    }
    emit(state.copyWith(isGameOver: true));
  }

  void startGame() {
    if (!_isTimerInitialized) {
      _timer = Timer.periodic(Constants.timer25, (_) {
        if (state.isGameOver) return;

        final newBallY = state.ballY + state.ballSpeed;
        final newBallSpeed = state.ballSpeed + 0.1;

        if (newBallY >= screenHeight || newBallY <= 0) {
          _endGame();
        }

        emit(state.copyWith(ballY: newBallY, ballSpeed: newBallSpeed));
      });
      _isTimerInitialized = true;
    }
  }

  void restartGame() {
    if (_isTimerInitialized) {
      _timer.cancel();
    }
    _isTimerInitialized = false;
    emit(GameState());
    startGame();
  }

  void _changeBallDirectionAndSpeed() {
    if (state.isGameOver) return;
    final newBallSpeed = -state.ballSpeed * 1.05;
    final newPoints = state.points + 1;

    emit(state.copyWith(ballSpeed: newBallSpeed, points: newPoints));
  }
}
