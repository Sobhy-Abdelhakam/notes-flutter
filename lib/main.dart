import 'package:flutter/material.dart';
import 'package:notes/core/utils/database_helper.dart';
import 'package:notes/data/repository/note_repository_impl.dart';
import 'package:notes/domain/usecases/add_note_usecase.dart';
import 'package:notes/domain/usecases/get_notes_usecase.dart';
import 'package:notes/presentation/viewModels/note_viewmodel.dart';
import 'package:provider/provider.dart';

import 'presentation/screens/home_page.dart';

void main() {
  // steps to create local storage project
  /*
  * 1- Add dependency => sqflite
  * 2- Define Data model (Note)
  * 3- Open the database
  * 4- Create table in database
  * 5 - then do operation to the table (Insert, Query, Update, Delete)
  * */

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) {
            return NoteViewModel(
              AddNoteUseCase(NoteRepositoryImpl(DatabaseHelper.instance)),
              GetNotesUseCase(NoteRepositoryImpl(DatabaseHelper.instance)),
            );
          },
        )
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}
