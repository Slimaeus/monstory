import 'package:flutter/material.dart';
import 'package:monstory/screens/game_play.dart';

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
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const GamePlay()));
              },
              child: const Text('Play')),
          ElevatedButton(
              onPressed: () {
                // TODO: Navigate to options
              },
              child: const Text('Options'))
        ]),
      ),
    );
  }
}
