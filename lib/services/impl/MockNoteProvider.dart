/*
Copyright Real Purdy Software LLC 2020
 */

import 'package:purdynotes/models/Note.dart';
import 'package:purdynotes/services/INoteRepository.dart';

class MockNoteProvider implements INoteRepository {
  static List<Note> _testData = [
    Note(0, "First Note Title", "First Note Content"),
    Note(2, "Second Note Title", "Second Note Content")
  ];

  List<Note> _notes = _testData;

  @override
  Future<List<Note>> allNotes() {
    return Future<List<Note>>.value(_notes);
  }

  @override
  Future<void> save(Note aNote) {
    Note noteToUpdate;
    for (final note in _notes) {
      if (note.getId() == aNote.getId()) {
        note.setContent(aNote.getContent());
        note.setTitle(aNote.getTitle());
        return Future<void>.value();
      }
    }
    //Not Found, add new
    _notes.add(aNote);
    return Future<void>.value();
  }

  Future<Note> create() {
    int id = _notes.length + 1;
    var newNote = Note(id, "", "");
    _notes.add(newNote);
    return Future<Note>.value(newNote);
  }

  Future<void> delete(Note aNote) {
    for (final note in _notes) {
      if (note.getId() == aNote.getId()) {
        _notes.remove(note);
        break;
      }
    }
    return Future<void>.value();
  }
}
