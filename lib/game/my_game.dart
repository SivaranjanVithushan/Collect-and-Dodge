import 'package:flame/camera.dart';
import 'package:flame/game.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mygame/game/boundary.dart';
import 'package:mygame/game/collectible.dart';
import 'package:mygame/game/collectible_spawner.dart';
import 'package:mygame/game/player.dart';

class MyGame extends FlameGame with HasCollisionDetection, KeyboardEvents {
  late Player player;
  int score = 0;
  int lives = 3;
  late TextComponent scoreText;
  late TextComponent livesText;
  static double gameWidth =
      MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.width;
  static double gameHeight =
      MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.height;

  final Set<LogicalKeyboardKey> _pressedKeys = {};

  @override
  Color backgroundColor() => const Color(0xFF000080); // Dark blue background

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    camera.viewport =
        FixedResolutionViewport(resolution: Vector2(gameWidth, gameHeight));

    player = Player();
    player.position = Vector2(
        gameWidth / 2,
        MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.height -
            100);
    add(player);

    scoreText = TextComponent(
      text: 'Score: $score',
      position: Vector2(10, 10),
    );
    add(scoreText);

    livesText = TextComponent(
      text: 'Lives: $lives',
      position: Vector2(10, 30),
    );
    add(livesText);

    add(CollectibleSpawner());

    // Add boundaries
    add(Boundary(Vector2(0, 0), Vector2(gameWidth, 10))); // Top
    add(Boundary(
        Vector2(0, gameHeight - 10), Vector2(gameWidth, 10))); // Bottom
    add(Boundary(Vector2(0, 0), Vector2(10, gameHeight))); // Left
    add(Boundary(Vector2(gameWidth - 10, 0), Vector2(10, gameHeight))); // Right
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (_pressedKeys.contains(LogicalKeyboardKey.arrowLeft)) {
      player.moveLeft(dt);
    }
    if (_pressedKeys.contains(LogicalKeyboardKey.arrowRight)) {
      player.moveRight(dt);
    }
  }

  @override
  KeyEventResult onKeyEvent(
    KeyEvent event,
    Set<LogicalKeyboardKey> keysPressed,
  ) {
    if (event is KeyDownEvent) {
      _pressedKeys.add(event.logicalKey);
      if (event.logicalKey == LogicalKeyboardKey.space) {
        player.fire();
      }
    } else if (event is KeyUpEvent) {
      _pressedKeys.remove(event.logicalKey);
    }

    return KeyEventResult.handled;
  }

  void incrementScore() {
    score++;
    scoreText.text = 'Score: $score';
  }

  void decrementLives() {
    lives--;
    livesText.text = 'Lives: $lives';
    if (lives <= 0) {
      gameOver();
    }
  }

  void gameOver() {
    pauseEngine();
    overlays.add('gameOver');
  }

  void resetGame() {
    score = 0;
    lives = 3;
    scoreText.text = 'Score: $score';
    livesText.text = 'Lives: $lives';
    // player.position = Vector2(
    //     gameWidth / 2,
    //     MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.height -
    //         50);
    removeWhere((component) => component is Collectible);
    resumeEngine();
  }
}
