import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'game/my_game.dart';

void main() {
  runApp(
    GameWidget.controlled(
      gameFactory: () => MyGame(),
      overlayBuilderMap: {
        'gameOver': (context, game) => GameOverOverlay(game as MyGame),
      },
    ),
  );
}

class GameOverOverlay extends StatelessWidget {
  final MyGame game;

  const GameOverOverlay(this.game, {super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: Colors.black.withOpacity(0.5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Game Over',
              style: TextStyle(fontSize: 48, color: Colors.white),
            ),
            const SizedBox(height: 20),
            Text(
              'Score: ${game.score}',
              style: const TextStyle(fontSize: 24, color: Colors.white),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text('Play Again'),
              onPressed: () {
                game.resetGame();
                game.overlays.remove('gameOver');
              },
            ),
          ],
        ),
      ),
    );
  }
}
