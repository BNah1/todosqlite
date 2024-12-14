import 'package:flutter/material.dart';
import 'package:todosqlite/todo/widget/todo_header.dart';
import 'package:todosqlite/todo/widget/todo_list.dart';

class TodoListContainer extends StatelessWidget {
  const TodoListContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TODO'),
      ),
      body: const Column(
        children: [
          TodoHeader(),
          Expanded(child: TodoList()),
        ],
      ),
    );
  }
}
