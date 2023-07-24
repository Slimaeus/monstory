import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:monstory/actors/jellyfish.dart';
import 'package:monstory/actors/turtle.dart';
import 'package:monstory/backgrounds/mountain.dart';

class MonstoryGame extends FlameGame with PanDetector, HasCollisionDetection {
  Offset? _pointerStartPosition;
  Offset? _pointerCurrentPosition;
  final double _joystickRadius = 40;
  MonstoryGame();

  late Turtle _turtle;
  late JellyFish _jellyFish;
  late JellyFish _jellyFishFake;
  late Mountain _mountain;

  final World world = World();
  late final CameraComponent cameraComponent;

  @override
  Future<void> onLoad() async {
    await images.loadAll([
      'background.png',
      'turtle/idle_turtle.png',
      'turtle/walk_turtle.png',
      'turtle/attack_turtle.png',
      'turtle/hurt_turtle.png',
      'turtle/death_turtle.png',
      'jellyfish/idle_jellyfish.png',
      'jellyfish/walk_jellyfish.png',
      'jellyfish/attack_jellyfish.png',
      'jellyfish/hurt_jellyfish.png',
      'jellyfish/death_jellyfish.png',
    ]);

    cameraComponent = CameraComponent(world: world);
    cameraComponent.viewfinder.anchor = Anchor.topLeft;
    addAll([cameraComponent, world]);

    _mountain = Mountain()..size = size;

    world.add(_mountain);

    _turtle = Turtle(position: Vector2(128, canvasSize.y - 500));
    _jellyFish = JellyFish(position: Vector2(128, canvasSize.y - 300));
    _jellyFishFake = JellyFish(position: Vector2(128, canvasSize.y - 300));

    world.add(_turtle);
    world.add(_jellyFish);
    world.add(_jellyFishFake);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    if (_pointerStartPosition != null) {
      canvas.drawCircle(_pointerStartPosition!, _joystickRadius,
          Paint()..color = Colors.grey.withAlpha(100));
    }

    if (_pointerCurrentPosition != null) {
      var delta = _pointerCurrentPosition! - _pointerStartPosition!;

      if (delta.distance > _joystickRadius) {
        delta = _pointerStartPosition! +
            Offset.fromDirection(delta.direction, _joystickRadius);
      } else {
        delta = _pointerCurrentPosition!;
      }

      canvas.drawCircle(
          delta, 10, Paint()..color = Colors.white.withAlpha(100));
    }
  }

  @override
  void onPanStart(DragStartInfo info) {
    _pointerStartPosition = info.eventPosition.global.toOffset();
    _pointerCurrentPosition = info.eventPosition.global.toOffset();
  }

  @override
  void onPanUpdate(DragUpdateInfo info) {
    _pointerCurrentPosition = info.eventPosition.global.toOffset();

    var delta = _pointerCurrentPosition! - _pointerStartPosition!;

    _jellyFish.setMoveDirection(Vector2(delta.dx, delta.dy));
  }

  @override
  void onPanEnd(DragEndInfo info) {
    _pointerStartPosition = null;
    _pointerCurrentPosition = null;
    _jellyFish.setMoveDirection(Vector2.zero());
  }

  @override
  void onPanCancel() {
    _pointerStartPosition = null;
    _pointerCurrentPosition = null;
    _jellyFish.setMoveDirection(Vector2.zero());
  }
}
