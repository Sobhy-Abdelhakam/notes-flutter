import 'package:notes/data/model/note_model.dart';

abstract class NoteRepository {
  Future<void> addNote(NoteModel note);
  Future<List<NoteModel>> getNotes();
}