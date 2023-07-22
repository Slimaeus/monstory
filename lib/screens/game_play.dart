import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:monstory/game/monstory_game.dart';

class GamePlay extends StatelessWidget {
  const GamePlay({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: const GameWidget<MonstoryGame>.controlled(
            gameFactory: MonstoryGame.new));
  }
}
