import 'package:flame/components.dart';
import 'package:monstory/actors/base_creature_sprite_animation_component.dart';
import 'package:monstory/enums/creature_state.dart';
import 'package:monstory/models/base_creature.dart';
import 'package:monstory/models/base_creature_stats.dart';

import 'jellyfish.dart';

class TurtleCreatureStats extends BaseCreatureStats {
  TurtleCreatureStats()
      : super(baseAttack: 1, baseDefence: 1, baseMaxHp: 100, baseSpeed: 1);
}

class TurtleCreature extends BaseCreature {
  TurtleCreature() : super(name: 'turtle', stats: TurtleCreatureStats());
}

class Turtle extends BaseCreatureSpriteAnimationComponent<TurtleCreature> {
  Turtle({required super.position}) : super(details: TurtleCreature());

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is JellyFish) {
      if (details.hp > 0) {
        int damage = 10;
        if (details.hp > damage) {
          details.hp -= damage;
          updateAnimation(CreatureState.hurt);
          Future.delayed(const Duration(seconds: 1)).then((value) => {
                if (state == CreatureState.hurt)
                  updateAnimation(CreatureState.idle)
              });
        } else {
          updateAnimation(CreatureState.death);
        }
      }
    } else if (other is Turtle) {
      details.hp = 100;
      updateAnimation(CreatureState.idle);
    }
    super.onCollisionStart(intersectionPoints, other);
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    if (state == CreatureState.death) return;
    if (other is Turtle) {
    } else if (other is JellyFish) {}
    super.onCollisionEnd(other);
  }
}
