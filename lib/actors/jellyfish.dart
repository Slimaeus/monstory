import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:monstory/actors/turtle.dart';
import 'package:monstory/game/monstory_game.dart';

enum CreatureState { idle, walk, attack, hurt, death }

class JellyFish extends SpriteAnimationComponent
    with HasGameRef<MonstoryGame>, CollisionCallbacks {
  Vector2 _moveDirection = Vector2.zero();

  final int _maxHp = 100;
  int _currentHp = 100;

  final double _speed = 300;

  late SpriteAnimation _idleAnimation;
  late SpriteAnimation _walkAnimation;
  late SpriteAnimation _attackAnimation;
  late SpriteAnimation _hurtAnimation;
  late SpriteAnimation _deathAnimation;

  CreatureState state = CreatureState.idle;

  late ShapeHitbox hitbox;

  JellyFish({required super.position})
      : super(size: Vector2.all(64), anchor: Anchor.center);

  @override
  FutureOr<void> onLoad() {
    _idleAnimation = SpriteAnimation.fromFrameData(
      game.images.fromCache('jellyfish/idle_jellyfish.png'),
      SpriteAnimationData.sequenced(
        amount: 4,
        textureSize: Vector2.all(48),
        stepTime: 0.12,
      ),
    );

    _walkAnimation = SpriteAnimation.fromFrameData(
      game.images.fromCache('jellyfish/walk_jellyfish.png'),
      SpriteAnimationData.sequenced(
        amount: 4,
        textureSize: Vector2.all(48),
        stepTime: 0.12,
      ),
    );

    _attackAnimation = SpriteAnimation.fromFrameData(
      game.images.fromCache('jellyfish/attack_jellyfish.png'),
      SpriteAnimationData.sequenced(
        amount: 4,
        textureSize: Vector2.all(48),
        stepTime: 0.12,
      ),
    );

    _hurtAnimation = SpriteAnimation.fromFrameData(
      game.images.fromCache('jellyfish/hurt_jellyfish.png'),
      SpriteAnimationData.sequenced(
        amount: 2,
        textureSize: Vector2.all(48),
        stepTime: 0.12,
      ),
    );

    _deathAnimation = SpriteAnimation.fromFrameData(
      game.images.fromCache('jellyfish/death_jellyfish.png'),
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
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Turtle) {
      // animation = _hurtAnimation;
      if (_currentHp > 0) {
        int damage = 10;
        if (_currentHp > damage) {
          _currentHp -= damage;
          updateAnimation(CreatureState.hurt);
          Future.delayed(const Duration(seconds: 1)).then((value) => {
                if (state == CreatureState.hurt)
                  updateAnimation(CreatureState.idle)
              });
        } else {
          // animation = _deathAnimation;
          updateAnimation(CreatureState.death);
        }
      }
    } else if (other is JellyFish) {
      _currentHp = 100;
      // animation = _idleAnimation;
      updateAnimation(CreatureState.idle);
    }
    super.onCollisionStart(intersectionPoints, other);
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    if (state == CreatureState.death) return;
    if (other is Turtle) {
      // animation = _idleAnimation;
      // updateAnimation(CreatureState.idle);
    } else if (other is JellyFish) {}
    super.onCollisionEnd(other);
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (state == CreatureState.death) return;
    if (_moveDirection.x != 0 || _moveDirection.y != 0) {
      // animation = _walkAnimation;
      updateAnimation(CreatureState.walk);
    }

    position += _moveDirection.normalized() * _speed * dt;
  }

  void setMoveDirection(Vector2 newMoveDirection) {
    if (newMoveDirection == Vector2.zero()) {
      updateAnimation(CreatureState.idle);
    }
    _moveDirection = newMoveDirection;
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
