import 'package:flame_splash_screen/flame_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:monstory/manager/route_manager.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({super.key});

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  bool showSplash = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: showSplash ? buildSplash() : buildMenu(),
    );
  }

  Widget buildSplash() {
    return FlameSplashScreen(
      theme: FlameSplashTheme.dark,
      onFinish: (BuildContext context) {
        setState(() {
          showSplash = false;
        });
      },
    );
  }

  Widget buildMenu() {
    return Scaffold(
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 50.0),
            child: Text('Monstory'),
          ),
          ElevatedButton(
              onPressed: () {
                context.go(RouteManager.gamePlay);
              },
              child: const Text('Play')),
          ElevatedButton(
              onPressed: () {
                context.go(RouteManager.options);
              },
              child: const Text('Options'))
        ]),
      ),
    );
  }
}
