import 'package:flutter/material.dart';
import 'package:notes/model/note_ui_model.dart';

class NoteItem extends StatelessWidget {
  final NoteUiModel note;
  const NoteItem({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8.0,
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Text(
                note.title,
                textAlign: TextAlign.start,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Text(note.content),
            ),
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Text(note.createdAt, textAlign: TextAlign.end,),
            )
          ],
        ),
      )
    );
  }
}
