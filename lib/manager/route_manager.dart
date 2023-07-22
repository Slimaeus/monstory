import 'package:flutter/widgets.dart';
import 'package:monstory/screens/game_play.dart';
import 'package:monstory/screens/main_menu.dart';
import 'package:monstory/screens/option_screen.dart';

class RouteManager {
  RouteManager._();

  static String gamePlay = '/game-play';
  static String options = '/options';
  static String home = '/home';

  static Map<String, Widget Function(BuildContext context)> routes = {
    home: (context) => const MainMenu(),
    gamePlay: (context) => const GamePlay(),
    options: (context) => const OptionScreen()
  };
}
