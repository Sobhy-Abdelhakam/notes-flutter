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
                    return InkWell(
                      child: NoteItem(note: note),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) {
                              return BlocProvider.value(
                                value: AppCubit.get(context),
                                child: AddNote(
                                  note: note,
                                ),
                              );
                            },
                          ),
                        );
                      },
                      // onDoubleTap: (){
                      //   cubit.deleteNote(note.id!);
                      // },
                    );
                  },
                ),
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
