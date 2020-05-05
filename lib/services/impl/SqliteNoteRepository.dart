/*
Copyright Real Purdy Software LLC 2020
 */

import 'package:purdynotes/models/Note.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'package:purdynotes/services/INoteRepository.dart';

class NotesTable
{
  static const String tableName = "notes";
  static const String idFieldName = "id";
  static const String titleFieldName = "title";
  static const String contentFieldName = "contentFieldName";
}

class SqliteNoteRepository extends INoteRepository {

  final Future<Database> database = getDatabasesPath().then((String path) {
    return openDatabase(join(path, "notes.db"),
        onCreate: (db, version) {
          db.execute(
              "CREATE TABLE ${NotesTable.tableName}( "
                  "${NotesTable.idFieldName} INTEGER PRIMARY KEY, "
                  "${NotesTable.titleFieldName} TEXT, "
                  "${NotesTable.contentFieldName} TEXT )");
        },
        version: 1);
  });

  Future<List<Note>> allNotes() async{
    var notes = List<Note>();
    final db = await database;

    var results = await db.query(NotesTable.tableName);
    results.forEach((map) => notes.add( _fromMap(map) ) );
    return notes;
  }

  Future<void> save(Note aNote) async{
    final db = await database;
    return await db.insert(NotesTable.tableName, _toMap(aNote), conflictAlgorithm: ConflictAlgorithm.replace );
  }

  Future<Note> create() async
  {
    final db = await database;
    int id = await _noteCount(db) + 1;
    var newNote = Note( id, "", "");
    await save(newNote);
    return newNote;
  }

  Future<void> delete(Note aNote) async {
    final db = await database;
    return db.delete(NotesTable.tableName, where: 'id = ?', whereArgs: [ aNote.getId() ]);
  }

  Map<String, dynamic> _toMap( Note aNote )
  {
    return {
      NotesTable.idFieldName: aNote.getId(),
      NotesTable.titleFieldName : aNote.getTitle(),
      NotesTable.contentFieldName : aNote.getContent()
    };
  }

  Note _fromMap(  Map<String, dynamic> aMap )
  {
    return Note( aMap[NotesTable.idFieldName], aMap[NotesTable.titleFieldName], aMap[NotesTable.contentFieldName] );
  }

  Future<int> _noteCount(Database db) async
  {
    return Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM ${NotesTable.tableName}'));
  }
}