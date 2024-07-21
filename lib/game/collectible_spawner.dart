import 'package:flame/components.dart';
import 'dart:math';
import 'my_game.dart';
import 'collectible.dart';

class CollectibleSpawner extends Component with HasGameRef<MyGame> {
  final Random _random = Random();
  double _spawnTimer = 0;

  @override
  void update(double dt) {
    super.update(dt);
    _spawnTimer += dt;
    if (_spawnTimer >= 1.0) {
      _spawnTimer = 0;
      final position =
          Vector2(_random.nextDouble() * (MyGame.gameWidth - 40) + 10, 0);
      gameRef.add(Collectible(position));
    }
  }
}
