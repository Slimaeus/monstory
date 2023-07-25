import 'package:flutter/material.dart';
import 'package:monstory/manager/route_manager.dart';

void main() {
  runApp(MaterialApp.router(
    debugShowCheckedModeBanner: false,
    themeMode: ThemeMode.dark,
    darkTheme: ThemeData.dark(),
    routerConfig: RouteManager.router,
  ));
}
