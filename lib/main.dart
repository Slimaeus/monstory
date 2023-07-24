import 'package:flutter/material.dart';
import 'package:monstory/manager/route_manager.dart';
import 'package:monstory/screens/main_menu.dart';

void main() {
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData.dark(),
      home: const MainMenu(),
      routes: {...RouteManager.routes}));
}
