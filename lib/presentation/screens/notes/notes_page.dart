import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/core/cubit/cubit.dart';
import 'package:notes/core/cubit/states.dart';
import 'package:notes/presentation/screens/add_note.dart';

import '../note_item.dart';

class NotesPage extends StatelessWidget {
  const NotesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppStates>(
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return Scaffold(
          body: state is NoteLoadingState
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: cubit.notes.length,
                  itemBuilder: (context, index) {
                    var note = cubit.notes[index];
                    return NoteItem(note: note);
                  },
                ),

          // FutureBuilder(
          //     future: viewModel.fetchNotes(),
          //     builder: (context, snapshot) {
          //       if (snapshot.connectionState == ConnectionState.waiting) {
          //         return const CircularProgressIndicator();
          //       } else if (snapshot.hasData) {
          //         final notes = snapshot.data as List<NoteModel>;
          //         if (notes.isEmpty) {
          //           return const Text('There are no data in database');
          //         }
          //         return ListView.builder(
          //             itemCount: notes.length,
          //             itemBuilder: (context, index) {
          //               return NoteItem(note: notes[index]);
          //             });
          //       } else {
          //         return const Center(child: Text('No notes available.'));
          //       }
          //     }),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) {
                    return BlocProvider.value(
                      value: AppCubit.get(context),
                      child: const AddNote(),
                    );
                  },
                ),
              );
            },
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}
