/*
Copyright Real Purdy Software LLC 2020
 */

import 'package:flutter/material.dart';
import "routes.dart";

class PurdyNotesApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Purdy Notes",
        initialRoute: appLanding,
        routes: appRoutes
    );
  }
}