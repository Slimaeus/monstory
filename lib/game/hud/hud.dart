import 'dart:async';

import 'package:flame/components.dart';
import 'package:monstory/game/monstory_game.dart';

class Hud extends Component with HasGameRef<MonstoryGame> {
  Hud({super.children, super.priority});

  @override
  FutureOr<void> onLoad() {
    final healthTextComponent =
        TextComponent(text: 'x5', anchor: Anchor.topLeft);

    add(healthTextComponent);
    return super.onLoad();
  }
}
