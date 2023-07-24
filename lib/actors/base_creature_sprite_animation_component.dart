import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:monstory/actors/turtle.dart';
import 'package:monstory/enums/creature_state.dart';
import 'package:monstory/game/monstory_game.dart';
import 'package:monstory/models/base_creature.dart';

import 'jellyfish.dart';

abstract class BaseCreatureSpriteAnimationComponent<T extends BaseCreature>
    extends SpriteAnimationComponent
    with HasGameRef<MonstoryGame>, CollisionCallbacks {
  T details;
  late SpriteAnimation _idleAnimation;
  late SpriteAnimation _walkAnimation;
  late SpriteAnimation _attackAnimation;
  late SpriteAnimation _hurtAnimation;
  late SpriteAnimation _deathAnimation;

  late ShapeHitbox hitbox;
  CreatureState state = CreatureState.idle;

  BaseCreatureSpriteAnimationComponent(
      {required this.details, required super.position})
      : super(size: Vector2.all(64), anchor: Anchor.center);

  @override
  FutureOr<void> onLoad() {
    _idleAnimation = SpriteAnimation.fromFrameData(
      game.images.fromCache('${details.name}/idle_${details.name}.png'),
      SpriteAnimationData.sequenced(
        amount: 4,
        textureSize: Vector2.all(48),
        stepTime: 0.12,
      ),
    );

    _walkAnimation = SpriteAnimation.fromFrameData(
      game.images.fromCache('${details.name}/walk_${details.name}.png'),
      SpriteAnimationData.sequenced(
        amount: 4,
        textureSize: Vector2.all(48),
        stepTime: 0.12,
      ),
    );

    _attackAnimation = SpriteAnimation.fromFrameData(
      game.images.fromCache('${details.name}/attack_${details.name}.png'),
      SpriteAnimationData.sequenced(
        amount: 4,
        textureSize: Vector2.all(48),
        stepTime: 0.12,
      ),
    );

    _hurtAnimation = SpriteAnimation.fromFrameData(
      game.images.fromCache('${details.name}/hurt_${details.name}.png'),
      SpriteAnimationData.sequenced(
        amount: 2,
        textureSize: Vector2.all(48),
        stepTime: 0.12,
      ),
    );

    _deathAnimation = SpriteAnimation.fromFrameData(
      game.images.fromCache('${details.name}/death_${details.name}.png'),
      SpriteAnimationData.sequenced(
        amount: 6,
        textureSize: Vector2.all(48),
        stepTime: 0.12,
      ),
    );

    animation = _idleAnimation;
    hitbox = CircleHitbox(
        radius: 24,
        collisionType: CollisionType.active,
        isSolid: true,
        anchor: Anchor.topLeft);
    add(hitbox);
    return super.onLoad();
  }

  void updateAnimation(CreatureState newState) {
    if (state == newState) return;
    switch (newState) {
      case CreatureState.idle:
        animation = _idleAnimation;
        break;
      case CreatureState.walk:
        animation = _walkAnimation;
        break;
      case CreatureState.attack:
        animation = _attackAnimation;
        break;
      case CreatureState.hurt:
        animation = _hurtAnimation;
        break;
      case CreatureState.death:
        animation = _deathAnimation;
        break;
    }
    state = newState;
  }
}
