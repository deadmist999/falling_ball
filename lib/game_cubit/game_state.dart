part of 'game_cubit.dart';

class GameState {
  final double ballY;
  final double ballSpeed;
  final int points;
  final bool isGameOver;

  GameState({
    this.ballY = 0,
    this.ballSpeed = 5,
    this.isGameOver = false,
    this.points = 0,
  });

  GameState copyWith({
    double? ballY,
    double? ballSpeed,
    int? points,
    bool? isGameOver,
  }) {
    return GameState(
      ballY: ballY ?? this.ballY,
      ballSpeed: ballSpeed ?? this.ballSpeed,
      points: points ?? this.points,
      isGameOver: isGameOver ?? this.isGameOver,
    );
  }
}
