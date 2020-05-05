/*
Copyright Real Purdy Software LLC 2020
 */

import 'package:flutter/cupertino.dart';

import 'package:purdynotes/routes/NotesListPage.dart';
import 'package:purdynotes/routes/NotePage.dart';

final appLanding = NotesListPage.routeName;
final Map<String, WidgetBuilder > appRoutes = <String, WidgetBuilder>{
  NotesListPage.routeName: (BuildContext context ) => NotesListPage(),
  NotePage.routeName: (BuildContext context ) => NotePage(),
};
