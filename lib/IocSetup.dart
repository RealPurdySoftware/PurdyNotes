/*
Copyright Real Purdy Software LLC 2020
 */

import 'package:purdynotes/services/impl/SqliteNoteRepository.dart';

import 'package:purdynotes/services/INoteRepository.dart';
import 'package:purdynotes/services/impl/MockNoteProvider.dart';
import 'package:purdynotes/serviceLocator.dart';

void iocSetup()
{
  serviceLocator.registerLazySingleton<INoteRepository>( ()=> SqliteNoteRepository() );
}