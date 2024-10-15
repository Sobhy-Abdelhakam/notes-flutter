import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/core/cubit/cubit.dart';
import 'package:notes/core/cubit/states.dart';

class TasksPage extends StatefulWidget {
  const TasksPage({super.key});

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  var scaffoldKey = GlobalKey<ScaffoldState>();

  var formKey = GlobalKey<FormState>();

  var todoController = TextEditingController();

  // TasksPage({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is InsertIntoTaskTableState) {
          Navigator.pop(context);
        }
        if (state is TaskLoadingState) {
          const Center(child: CircularProgressIndicator());
        }
      },
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);
        return Scaffold(
          key: scaffoldKey,
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              if (cubit.isBottomSheetOpen) {
                Navigator.pop(context);
              } else {
                scaffoldKey.currentState
                    ?.showBottomSheet(
                      (context) {
                        return Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Form(
                            key: formKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextFormField(
                                  controller: todoController,
                                  decoration: const InputDecoration(
                                    hintText: 'To-do',
                                    filled: true,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(32.0)),
                                    ),
                                  ),
                                  keyboardType: TextInputType.text,
                                  validator: (value) {
                                    if (value != null) {
                                      if (value.isEmpty) {
                                        return 'to-do must not be empty';
                                      }
                                      return null;
                                    }
                                    return 'to-do must not be empty or blank';
                                  },
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      cubit.insertTask(todoController.text);
                                    }
                                  },
                                  child: const Text("SAVE"),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      elevation: 32.0,
                      showDragHandle: true,
                    )
                    .closed
                    .then(
                      (_) {
                        cubit.changeBottomSheet(false, Icons.edit);
                      },
                    );
                cubit.changeBottomSheet(true, Icons.close);
              }
            },
            child: Icon(cubit.fabIcon),
          ),
          body: ListView.builder(
            itemCount: cubit.tasks.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: const Icon(Icons.insert_emoticon),
                title: Text('Title: ${cubit.tasks[index]['title']}'),
              );
            },
          ),
        );
      },
    );
  }
}
