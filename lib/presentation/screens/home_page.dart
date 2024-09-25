import 'package:flutter/material.dart';
import 'package:notes/data/model/note_model.dart';
import 'package:notes/presentation/screens/add_note.dart';
import 'package:provider/provider.dart';

import '../viewModels/note_viewmodel.dart';
import 'note_item.dart';


class HomePage extends StatelessWidget {


  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<NoteViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
      ),
      body: FutureBuilder(
          future: viewModel.fetchNotes(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasData) {
              final notes = snapshot.data as List<NoteModel>;
              if (notes.isEmpty){
                return const Text('There are no data in database');
              }
              return ListView.builder(
                  itemCount: notes.length,
                  itemBuilder: (context, index) {
                    return NoteItem(note: notes[index]);
                  });
            } else {
              return const Center(child: Text('No notes available.'));
            }
          }
      ),
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
