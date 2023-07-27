import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter/material.dart';
import 'package:monstory/actors/jellyfish.dart';
import 'package:monstory/actors/shark.dart';
import 'package:monstory/actors/turtle.dart';
import 'package:monstory/backgrounds/mountain.dart';
import 'package:monstory/game/hud/hud.dart';
import 'package:monstory/game/levels/level.dart';

class MonstoryGame extends FlameGame with PanDetector, HasCollisionDetection {
  Offset? _pointerStartPosition;
  Offset? _pointerCurrentPosition;
  final double _joystickRadius = 40;
  MonstoryGame();

  late JellyFish _jellyFish;
  late JellyFish _jellyFishFake;
  late Turtle _turtle;
  late Shark _shark;
  late Mountain _mountain;

  final World world = World();
  late final CameraComponent cameraComponent;

  Level? _currentLevel;
  int _currentMapIndex = 0;
  final List<String> _levelResources = ['GreenZoneMap.tmx', 'MarketMap.tmx'];

  @override
  Future<void> onLoad() async {
    await Flame.device.fullScreen();
    await Flame.device.setPortrait();

    await images.loadAll([
      'background.png',
      'jellyfish/idle_jellyfish.png',
      'jellyfish/walk_jellyfish.png',
      'jellyfish/attack_jellyfish.png',
      'jellyfish/hurt_jellyfish.png',
      'jellyfish/death_jellyfish.png',
      'turtle/idle_turtle.png',
      'turtle/walk_turtle.png',
      'turtle/attack_turtle.png',
      'turtle/hurt_turtle.png',
      'turtle/death_turtle.png',
      'shark/idle_shark.png',
      'shark/walk_shark.png',
      'shark/attack_shark.png',
      'shark/hurt_shark.png',
      'shark/death_shark.png',
    ]);

    cameraComponent = CameraComponent(
      world: world,
      hudComponents: [Hud()],
    );
    cameraComponent.viewfinder.anchor = Anchor.topLeft;
    cameraComponent.viewport.add(Hud());

    cameraComponent.viewport.size = Vector2(600, 600);

    addAll([cameraComponent, world]);

    _mountain = Mountain()..size = size;

    world.add(_mountain);

    loadLevel(_levelResources[_currentMapIndex]);

    _jellyFish = JellyFish(position: Vector2(64, canvasSize.y - 300));
    _jellyFishFake = JellyFish(position: Vector2(128, canvasSize.y - 300));
    _turtle = Turtle(position: Vector2(192, canvasSize.y - 300));
    _shark = Shark(position: Vector2(256, canvasSize.y - 300));

    world.add(_jellyFish);
    world.add(_jellyFishFake);
    world.add(_turtle);
    world.add(_shark);

    // overlays.add(OverlayManager.pauseOverlay);
  }

  void loadLevel(String levelName) {
    _currentLevel?.removeFromParent();
    _currentLevel = Level(levelName);
    add(_currentLevel!);
  }

  @override
  void update(double dt) {
    super.update(dt);
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
    if (_currentMapIndex == 0) {
      _currentMapIndex = 1;
    } else {
      _currentMapIndex = 0;
    }
    loadLevel(_levelResources[_currentMapIndex]);
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
