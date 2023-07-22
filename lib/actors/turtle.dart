import 'dart:async';

import 'package:flame/components.dart';
import 'package:monstory/game/monstory_game.dart';

class Turtle extends SpriteAnimationComponent with HasGameRef<MonstoryGame> {
  final int speed;
  bool movingOnXAxis = true;
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
  }

  @override
  void update(double dt) {
    final screenSize = gameRef.size;
    if (movingOnXAxis) {
      // Move on the X-axis
      if (position.x <= 0) {
        position.x = 0;
        movingOnXAxis = false;
      } else if (position.x + size.x >= screenSize.x) {
        position.x = screenSize.x - size.x;
        movingOnXAxis = false;
      } else {
        position.x = position.x + speed * dt;
      }
    } else {
      // Move on the Y-axis
      if (position.y <= 0) {
        position.y = 0;
        movingOnXAxis = true;
      } else if (position.y + size.y >= screenSize.y) {
        position.y = screenSize.y - size.y;
        position.x = 0;
        position.y = 100;
        movingOnXAxis = true;
      } else {
        position.y = position.y + speed * dt;
      }
    }
  }
}
