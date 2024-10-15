import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/core/cubit/states.dart';
import 'package:notes/core/utils/database_helper.dart';
import 'package:notes/data/model/note_model.dart';

class AppCubit extends Cubit<AppStates> {
  final DatabaseHelper _databaseHelper = DatabaseHelper.instance;
  List<Map> tasks = [];
  List<NoteModel> notes = [];
  AppCubit() : super(InitState()) {
    getNotes();
    getTasks();
  }

  static AppCubit get(context) => BlocProvider.of(context);

  // Bottom Navigation
  int bottomNavCurrentIndex = 0;
  void changeBottomNavIndex(int index) {
    bottomNavCurrentIndex = index;
    emit(BottomNavChangeState());
  }

  insertTask(String task) {
    _databaseHelper.insertTask(task).then((_) {
      print('add task successfully');
      emit(InsertIntoTaskTableState());
      getTasks();
    }).catchError((error) {
      print('Error insert: $error');
    });
  }

  getTasks() {
    emit(TaskLoadingState());
    _databaseHelper.getTasks().then((tasksList) {
      tasks = tasksList;
      emit(GetTasksFromDatabaseState());
    }).catchError((error) {
      print('Error Get: $error');
    });
  }

  insertNote(String title, String content) {
    _databaseHelper
        .insertNote(
      NoteModel(
        id: null,
        title: title,
        content: content,
        createdAt: DateTime.now(),
      ),
    )
        .then(
      (_) {
        print('add note successfully');
        emit(InsertIntoNoteTableState());
        getNotes();
      },
    ).catchError(
      (error) {
        print('insertNoteError: $error');
      },
    );
  }

  getNotes() {
    emit(NoteLoadingState());
    _databaseHelper.getNotes().then(
      (notesList) {
        notes = notesList;
        emit(GetNotesFromDatabaseState());
      },
    ).catchError(
      (error) {
        print('getNotesError: $error');
      },
    );
  }

  // Bottom Sheet
  bool isBottomSheetOpen = false;
  IconData fabIcon = Icons.edit;
  void changeBottomSheet(bool isShow, IconData icon) {
    isBottomSheetOpen = isShow;
    fabIcon = icon;
    emit(ChangeBottomSheetState());
  }
}
