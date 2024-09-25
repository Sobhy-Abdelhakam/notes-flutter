import 'package:flutter/material.dart';
import 'package:notes/data/model/note_model.dart';
import 'package:notes/domain/usecases/add_note_usecase.dart';
import 'package:notes/domain/usecases/get_notes_usecase.dart';


class NoteViewModel extends ChangeNotifier {
  final AddNoteUseCase _addNoteUseCase;
  final GetNotesUseCase _getNotesUseCase;

  NoteViewModel(this._addNoteUseCase, this._getNotesUseCase);

  Future<void> addNote(String title, String content) async {
    final note = NoteModel(id: null, title: title, content: content, createdAt: DateTime.now());
    await _addNoteUseCase.execute(note);
  }

  Future<List<NoteModel>> fetchNotes() async {
    return await _getNotesUseCase.execute();
  }
}