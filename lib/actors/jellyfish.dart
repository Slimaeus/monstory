import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:monstory/actors/turtle.dart';
import 'package:monstory/game/monstory_game.dart';

class JellyFish extends SpriteAnimationComponent
    with HasGameRef<MonstoryGame>, CollisionCallbacks {
  Vector2 _moveDirection = Vector2.zero();

  final int _maxHp = 100;
  int _currentHp = 100;

  final double _speed = 300;

  late ShapeHitbox hitbox;

  JellyFish({required super.position})
      : super(size: Vector2.all(64), anchor: Anchor.center);

  @override
  FutureOr<void> onLoad() {
    animation = SpriteAnimation.fromFrameData(
      game.images.fromCache('idle_jellyfish.png'),
      SpriteAnimationData.sequenced(
        amount: 4,
        textureSize: Vector2.all(48),
        stepTime: 0.12,
      ),
    );
    hitbox = CircleHitbox(
        radius: 24,
        collisionType: CollisionType.active,
        isSolid: true,
        anchor: Anchor.topLeft);
    add(hitbox);
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Turtle) {
      _currentHp -= 100;
      print('Hello');
    } else if (other is JellyFish) {
      _currentHp += 100;
    }
    super.onCollisionStart(intersectionPoints, other);
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (_currentHp <= 0) {
      size = Vector2(1000, 1000);
    } else {
      size = Vector2(100, 100);
    }
    position += _moveDirection.normalized() * _speed * dt;
  }

  void setMoveDirection(Vector2 newMoveDirection) {
    _moveDirection = newMoveDirection;
  }
}
