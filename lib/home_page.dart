import 'package:flutter/material.dart';
import 'package:notes/add_note.dart';
import 'package:notes/model/note_ui_model.dart';
import 'package:notes/note_item.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    List<NoteUiModel> notes = [
      NoteUiModel(0, 'title1', 'this is the content of note 1', 'createdAt'),
      NoteUiModel(1, 'title2', 'this is the content of note 2', 'createdAt'),
      NoteUiModel(2, 'title3', 'this is the content of note 3', 'createdAt'),
      NoteUiModel(3, 'title4', 'this is the content of note 4', 'createdAt'),
      NoteUiModel(0, 'title1', 'this is the content of note 1', 'createdAt'),
      NoteUiModel(1, 'title2', 'this is the content of note 2', 'createdAt'),
      NoteUiModel(2, 'title3', 'this is the content of note 3', 'createdAt'),
      NoteUiModel(3, 'title4', 'this is the content of note 4', 'createdAt'),
      NoteUiModel(0, 'title1', 'this is the content of note 1', 'createdAt'),
      NoteUiModel(1, 'title2', 'this is the content of note 2', 'createdAt'),
      NoteUiModel(2, 'title3', 'this is the content of note 3', 'createdAt'),
      NoteUiModel(3, 'title4', 'this is the content of note 4', 'createdAt'),
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
      ),
      body: ListView.builder(
          itemCount: notes.length,
          itemBuilder: (context, index) {
            return NoteItem(note: notes[index]);
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return const AddNote();
          }));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
