/*
Copyright Real Purdy Software LLC 2020
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:purdynotes/models/Note.dart';
import 'package:purdynotes/services/INoteRepository.dart';

import 'package:purdynotes/serviceLocator.dart';

class NotePage extends StatefulWidget {
  static const routeName = "NotePage";

  @override
  State<StatefulWidget> createState() => NotePageState();
}

class NotePageState extends State<NotePage> {
  final INoteRepository _noteRepository = serviceLocator<INoteRepository>();
  Note currentNote;

  @override
  Widget build(BuildContext context) {
    _initState(context);

    return WillPopScope(
      onWillPop: _saveChanges,
      child: _pageContent(context),
    );
  }

  Widget _pageContent(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Purdy Notes"),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.delete),
              tooltip: "Delete Note",
              onPressed: () {
                _noteRepository.delete(currentNote);
                Navigator.pop(context);
              },
            )
          ],
        ),
        body: Column(
          children: <Widget>[
            _noteTitle(),
            Divider(thickness: 2.0),
            _noteContent()
          ],
        ));
  }

  Widget _noteTitle() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextField(
        autofocus: currentNote.getTitle().isEmpty,
        controller: TextEditingController(text: currentNote.getTitle()),
        onChanged: (text) => currentNote.setTitle(text),
        decoration:
            InputDecoration(hintText: "Note Title", border: InputBorder.none),
      ),
    );
  }

  Widget _noteContent() {
    return Expanded(
        child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20.0),
            child: TextField(
              autofocus: currentNote.getTitle().isNotEmpty,
              maxLines: null,
              minLines: null,
              expands: true,
              keyboardType: TextInputType.multiline,
              onChanged: (text) => currentNote.setContent(text),
              controller: TextEditingController(text: currentNote.getContent()),
              decoration: InputDecoration(
                hintText: "Note Content",
              ),
            )));
  }

  void _initState(BuildContext context) {
    currentNote = ModalRoute.of(context).settings.arguments;
  }

  Future<bool> _saveChanges() async {
    await _noteRepository.save(currentNote);
    return Future<bool>.value(true);
  }
}
