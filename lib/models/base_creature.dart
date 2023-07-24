// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:monstory/models/base_creature_stats.dart';

abstract class BaseCreature {
  BaseCreatureStats stats;
  String name;
  int maxHp;
  int hp;
  int attack;
  int defence;
  int speed;
  BaseCreature({
    required this.stats,
    required this.name,
    this.maxHp = 100,
    this.hp = 100,
    this.attack = 1,
    this.defence = 1,
    this.speed = 1,
  }) {
    maxHp = stats.baseMaxHp;
    hp = stats.baseMaxHp;
    attack = stats.baseAttack;
    defence = stats.baseDefence;
    speed = stats.baseDefence;
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'maxHp': maxHp,
      'hp': hp,
      'attack': attack,
      'defence': defence,
      'speed': speed,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'BaseCreature(name: $name, maxHp: $maxHp, hp: $hp, attack: $attack, defence: $defence, speed: $speed)';
  }

  @override
  bool operator ==(covariant BaseCreature other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.maxHp == maxHp &&
        other.hp == hp &&
        other.attack == attack &&
        other.defence == defence &&
        other.speed == speed;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        maxHp.hashCode ^
        hp.hashCode ^
        attack.hashCode ^
        defence.hashCode ^
        speed.hashCode;
  }
}
