import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/core/cubit/cubit.dart';
import 'package:notes/core/cubit/states.dart';
import 'package:notes/presentation/screens/notes/notes_page.dart';
import 'package:notes/presentation/screens/tasks/tasks_page.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AppCubit(),
      child: BlocBuilder<AppCubit, AppStates>(
        builder: (context, state) {
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title:
                  Text(cubit.bottomNavCurrentIndex == 0 ? 'Notes' : 'To-dos'),
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.bottomNavCurrentIndex,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.document_scanner),
                  label: 'Notes',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.check_circle_outline),
                  label: 'To-dos',
                )
              ],
              onTap: (index) {
                cubit.changeBottomNavIndex(index);
              },
            ),
            body: cubit.bottomNavCurrentIndex == 0
                ? const NotesPage()
                : const TasksPage(),
          );
        },
      ),
    );
  }
}
