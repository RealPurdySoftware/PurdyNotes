/*
Copyright Real Purdy Software LLC 2020
 */

import 'package:flutter/material.dart';
import 'package:purdynotes/PurdyNotesApp.dart';
import 'package:purdynotes/IocSetup.dart';

void main()
{
  iocSetup();
  runApp(PurdyNotesApp());
}