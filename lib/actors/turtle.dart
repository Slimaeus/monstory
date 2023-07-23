import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:monstory/game/monstory_game.dart';

class Turtle extends SpriteAnimationComponent
    with HasGameRef<MonstoryGame>, CollisionCallbacks {
  final int speed;
  bool movingOnXAxis = true;
  Vector2 velocity = Vector2.zero();

  late ShapeHitbox hitbox;
  Turtle({required super.position, required this.speed})
      : super(size: Vector2.all(64), anchor: Anchor.center);

  @override
  FutureOr<void> onLoad() {
    animation = SpriteAnimation.fromFrameData(
      game.images.fromCache('idle_turtle.png'),
      SpriteAnimationData.sequenced(
        amount: 4,
        textureSize: Vector2.all(48),
        stepTime: 0.12,
      ),
    );
    hitbox = CircleHitbox(
        radius: 24, collisionType: CollisionType.passive, isSolid: true);
    add(hitbox);
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (velocity.y > 50000) {
      velocity = Vector2(velocity.x, 0);
    }
    if (position.y > gameRef.size[1]) {
      velocity = Vector2.zero();
      position = Vector2(100, 0);
      return;
    }
    velocity += Vector2(0, 9.8);
    position += velocity * dt;
  }
}
