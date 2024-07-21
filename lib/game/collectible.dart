import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import 'package:flutter/material.dart';
import 'my_game.dart';
import 'player.dart';

class Collectible extends PositionComponent
    with CollisionCallbacks, HasGameRef<MyGame> {
  static final _paint = Paint()..color = Colors.red;

  Collectible(Vector2 position)
      : super(size: Vector2(30, 30), position: position) {
    add(RectangleHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.y += 100 * dt;
    if (position.y > MyGame.gameHeight) {
      removeFromParent();
      gameRef.decrementLives();
    }
  }

  @override
  void render(Canvas canvas) {
    canvas.drawRect(size.toRect(), _paint);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (other is Player) {
      removeFromParent();
      gameRef.incrementScore();
    }
  }
}
