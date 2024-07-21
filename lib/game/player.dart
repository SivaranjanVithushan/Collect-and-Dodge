import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import 'package:flutter/services.dart';
import 'my_game.dart';
import 'bullet.dart';

class Player extends SpriteComponent
    with CollisionCallbacks, HasGameRef<MyGame>, KeyboardHandler {
  static const speed = 200.0;
  bool canFire = true;
  final double fireDelay = 0.5;

  Player() : super(size: Vector2(50, 50), position: Vector2(175, 500));

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    sprite = await gameRef.loadSprite('player_ship.png');
    size = Vector2(50, 50 * sprite!.originalSize.x / sprite!.originalSize.y);
    final shape = CircleHitbox.relative(0.8,
        parentSize: size, position: size / 2, anchor: Anchor.center);
    add(shape);
  }

  void moveLeft(double dt) {
    position.x -= speed * dt;
    position.x = position.x.clamp(0, gameRef.size.x - width);
  }

  void moveRight(double dt) {
    position.x += speed * dt;
    position.x = position.x.clamp(0, gameRef.size.x - width);
  }

  void fire() {
    if (canFire) {
      final bullet = Bullet(Vector2(position.x + size.x / 2 - 5, position.y));
      gameRef.add(bullet);
      canFire = false;
      Future.delayed(Duration(milliseconds: (fireDelay * 1000).toInt()),
          () => canFire = true);
    }
  }

  @override
  bool onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    if (event is KeyDownEvent && event.logicalKey == LogicalKeyboardKey.space) {
      fire();
      return true;
    }
    return false;
  }
}
