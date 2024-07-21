import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import 'my_game.dart';
import 'collectible.dart';

class Bullet extends SpriteComponent
    with CollisionCallbacks, HasGameRef<MyGame> {
  static const speed = 300.0;

  Bullet(Vector2 position) : super(size: Vector2(10, 20), position: position);

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    sprite = await gameRef.loadSprite('bullet.png');
    add(RectangleHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.y -= speed * dt;
    if (position.y < -height) {
      removeFromParent();
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (other is Collectible) {
      other.destroy();
      removeFromParent();
    }
  }
}
