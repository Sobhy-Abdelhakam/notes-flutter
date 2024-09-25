import 'package:notes/core/utils/database_helper.dart';
import 'package:notes/data/model/note_model.dart';
import 'package:notes/domain/repository/note_repository.dart';

class NoteRepositoryImpl implements NoteRepository {
  final DatabaseHelper _databaseHelper;

  NoteRepositoryImpl(this._databaseHelper);

  @override
  Future<void> addNote(NoteModel note) async{
    await _databaseHelper.insertNote(note);
  }

  @override
  Future<List<NoteModel>> getNotes() {
    return _databaseHelper.getNotes();
  }
}
