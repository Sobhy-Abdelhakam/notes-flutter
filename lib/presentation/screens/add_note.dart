import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewModels/note_viewmodel.dart';

class AddNote extends StatefulWidget {
  const AddNote({super.key});

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<NoteViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
                icon: const Icon(
                  Icons.check,
                ),
              onPressed: (){
                  viewModel.addNote(titleController.text, contentController.text);
                  Navigator.pop(context);
              },
            )
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Title',
                ),
                style: const TextStyle(fontSize: 25.0),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: contentController,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Enter note',
                ),
                minLines: 10,
                maxLines: null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
