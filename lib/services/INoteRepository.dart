/*
Copyright Real Purdy Software LLC 2020
 */

import 'package:purdynotes/models/Note.dart';

class INoteRepository
{
  Future<List<Note>> allNotes() => null;
  Future<void> save( Note aNote) => Future<void>.value();
  Future<Note> create() => Future<Note>.value(null);
  Future<void> delete(Note aNote) => Future<void>.value();
}