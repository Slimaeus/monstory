import 'package:flutter/material.dart';
import 'package:monstory/manager/route_manager.dart';

class MainMenu extends StatelessWidget {
  const MainMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 50.0),
            child: Text('Monstory'),
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.of(context)
                    .pushReplacementNamed(RouteManager.gamePlay);
              },
              child: const Text('Play')),
          ElevatedButton(
              onPressed: () {
                Navigator.of(context)
                    .pushReplacementNamed(RouteManager.options);
              },
              child: const Text('Options'))
        ]),
      ),
    );
  }
}
