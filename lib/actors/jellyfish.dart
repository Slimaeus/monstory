import 'dart:async';

import 'package:flame/components.dart';
import 'package:monstory/game/monstory_game.dart';

class JellyFish extends SpriteAnimationComponent with HasGameRef<MonstoryGame> {
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
  }
}
