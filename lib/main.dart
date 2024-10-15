import 'package:flutter/material.dart';
import 'package:notes/presentation/screens/home_layout.dart';

void main() {
  // steps to create local storage project
  /*
  * 1- Add dependency => sqflite
  * 2- Define Data model (Note)
  * 3- Open the database
  * 4- Create table in database
  * 5 - then do operation to the table (Insert, Query, Update, Delete)
  * */

  runApp(const MyApp(),);
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
      home: const HomeLayout(),
    );
  }
}
