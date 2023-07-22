import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:monstory/actors/jellyfish.dart';
import 'package:monstory/actors/turtle.dart';
import 'package:monstory/backgrounds/mountain.dart';

class MonstoryGame extends FlameGame {
  MonstoryGame();

  late Turtle _turtle;
  late JellyFish _jellyFish;
  late Mountain _mountain;

  final World world = World();
  late final CameraComponent cameraComponent;

  @override
  Future<void> onLoad() async {
    await images
        .loadAll(['background.png', 'idle_turtle.png', 'idle_jellyfish.png']);

    cameraComponent = CameraComponent(world: world);
    cameraComponent.viewfinder.anchor = Anchor.topLeft;
    addAll([cameraComponent, world]);

    _mountain = Mountain()..size = size;

    world.add(_mountain);

    _turtle = Turtle(position: Vector2(128, canvasSize.y - 500), speed: 1000);
    _jellyFish = JellyFish(position: Vector2(128, canvasSize.y - 300));

    world.add(_turtle);
    world.add(_jellyFish);
  }
}
