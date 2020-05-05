/*
Copyright Real Purdy Software LLC 2020
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:purdynotes/models/Note.dart';
import 'package:purdynotes/serviceLocator.dart';
import 'package:purdynotes/services/INoteRepository.dart';
import 'package:purdynotes/routes/NotePage.dart';

class NotesListPage extends StatefulWidget {
  static const routeName = "NotesListPage";

  @override
  State<StatefulWidget> createState() => NotesListPageState();
}

class NotesListPageState extends State<NotesListPage> {
  final INoteRepository _noteProvider = serviceLocator<INoteRepository>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Real Purdy Notes"),
      ),
      body: _noteRows(),
      floatingActionButton: FloatingActionButton(
          onPressed: _transitionToNewNotePage,
          tooltip: "New Note",
          child: Icon(Icons.add)),
    );
  }

  void _transitionToNewNotePage() async {
    var note = await _noteProvider.create();
    Navigator.pushNamed(context, NotePage.routeName, arguments: note);
  }

  Widget _noteRows() {
    return FutureBuilder(
        future: _noteProvider.allNotes(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return ListView.builder(
                itemCount: snapshot.data != null ? snapshot.data.length : 0,
                itemBuilder: (context, index) {
                  return _buildRow(snapshot.data[index]);
                });
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  Widget _buildRow(Note aNote) {
    return Column(children: <Widget>[
      ListTile(
        title: Text(aNote.getTitle()),
        onTap: () =>
            Navigator.pushNamed(context, NotePage.routeName, arguments: aNote),
      ),
      Divider(
        thickness: 2.0,
      )
    ]);
  }
}
