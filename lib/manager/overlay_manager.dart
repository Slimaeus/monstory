import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:monstory/game/widgets/pause_overlay.dart';

class OverlayManager {
  OverlayManager._();

  static String pauseOverlay = '/pauseOverlay';

  static Map<String, Widget Function(BuildContext, Game)> overlays = {
    pauseOverlay: (context, game) => PauseOverlay(game)
  };
}
