import 'dart:async';

import 'package:flame/components.dart';
import 'package:monstory/game/monstory_game.dart';

class Mountain extends SpriteComponent with HasGameRef<MonstoryGame> {
  Mountain();

  @override
  Future<void> onLoad() async {
    sprite = await Sprite.load('background.png');
  }
}
