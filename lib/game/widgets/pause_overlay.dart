import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class PauseOverlay extends StatelessWidget {
  final Game game;
  const PauseOverlay(this.game, {super.key});

  @override
  Widget build(BuildContext context) {
    return const Text('Pause');
  }
}
