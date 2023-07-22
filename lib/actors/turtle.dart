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
}
