import 'package:notes/data/model/note_model.dart';
import 'package:notes/domain/repository/note_repository.dart';

class GetNotesUseCase {
  final NoteRepository noteRepository;
  GetNotesUseCase(this.noteRepository);
  Future<List<NoteModel>> execute(){
    return noteRepository.getNotes();
  }
}