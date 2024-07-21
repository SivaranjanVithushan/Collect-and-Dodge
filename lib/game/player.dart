import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import 'package:flutter/material.dart';
import 'my_game.dart';

class Player extends PositionComponent
    with CollisionCallbacks, HasGameRef<MyGame> {
  static final _paint = Paint()..color = Colors.blue;
  static const speed = 200.0;

  Player() : super(size: Vector2(50, 50), position: Vector2(175, 500)) {
    add(RectangleHitbox());
  }

  void moveLeft(double dt) {
    position.x -= speed * dt;
    position.x = position.x.clamp(10, gameRef.size.x - 60);
  }

  void moveRight(double dt) {
    position.x += speed * dt;
    position.x = position.x.clamp(10, gameRef.size.x - 60);
  }

  @override
  void render(Canvas canvas) {
    canvas.drawRect(size.toRect(), _paint);
  }
}
