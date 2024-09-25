import 'package:notes/data/model/note_model.dart';
import 'package:notes/domain/repository/note_repository.dart';

class AddNoteUseCase {
  final NoteRepository noteRepository;

  AddNoteUseCase(this.noteRepository);

  Future<void> execute(NoteModel note) {
    return noteRepository.addNote(note);
  }
}
