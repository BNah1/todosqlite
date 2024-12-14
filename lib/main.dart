import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todosqlite/todo/bloc/todo_bloc.dart';
import 'package:todosqlite/todo/database/todo_database.dart';
import 'package:todosqlite/todo/screen/todo_list_container.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await TodoDatabase.instance.init();
  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Provider<TodoBloc>.value(
          value: TodoBloc(),
          child: TodoListContainer())
    );
  }
}
