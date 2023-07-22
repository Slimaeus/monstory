import 'package:flutter/material.dart';
import 'package:monstory/screens/main_menu.dart';

void main() {
  runApp(MaterialApp(
    themeMode: ThemeMode.dark,
    darkTheme: ThemeData.dark(),
    home: const MainMenu(),
  ));
}
