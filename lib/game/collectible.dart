import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import 'my_game.dart';
import 'player.dart';

class Collectible extends SpriteComponent
    with CollisionCallbacks, HasGameRef<MyGame> {
  Collectible(Vector2 position)
      : super(size: Vector2(30, 30), position: position);

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    sprite = await gameRef.loadSprite('collectible.png');
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
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (other is Player) {
      destroy();
      gameRef.incrementScore();
    }
  }

  void destroy() {
    removeFromParent();
  }
}
