import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import 'package:flutter/material.dart';

class Boundary extends PositionComponent with CollisionCallbacks {
  Boundary(Vector2 position, Vector2 size)
      : super(position: position, size: size) {
    add(RectangleHitbox());
  }

  @override
  void render(Canvas canvas) {
    canvas.drawRect(size.toRect(), Paint()..color = Colors.grey);
  }
}
