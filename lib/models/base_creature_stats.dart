// ignore_for_file: public_member_api_docs, sort_constructors_first

abstract class BaseCreatureStats {
  int baseMaxHp;
  int baseAttack;
  int baseDefence;
  int baseSpeed;
  BaseCreatureStats({
    required this.baseMaxHp,
    required this.baseAttack,
    required this.baseDefence,
    required this.baseSpeed,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'baseMaxHp': baseMaxHp,
      'baseAttack': baseAttack,
      'baseDefence': baseDefence,
      'baseSpeed': baseSpeed,
    };
  }

  @override
  String toString() {
    return 'BaseCreatureStats(baseMaxHp: $baseMaxHp, baseAttack: $baseAttack, baseDefence: $baseDefence, baseSpeed: $baseSpeed)';
  }

  @override
  bool operator ==(covariant BaseCreatureStats other) {
    if (identical(this, other)) return true;

    return other.baseMaxHp == baseMaxHp &&
        other.baseAttack == baseAttack &&
        other.baseDefence == baseDefence &&
        other.baseSpeed == baseSpeed;
  }

  @override
  int get hashCode {
    return baseMaxHp.hashCode ^
        baseAttack.hashCode ^
        baseDefence.hashCode ^
        baseSpeed.hashCode;
  }
}
