import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todosqlite/todo/bloc/todo_bloc.dart';
import 'package:todosqlite/todo/event/add_todo_event.dart';

class TodoHeader extends StatelessWidget {
  const TodoHeader({super.key});

  @override
  Widget build(BuildContext context) {
    var txtController = TextEditingController();
    var bloc = Provider.of<TodoBloc>(context);
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: TextField(
              controller: txtController,
              decoration: const InputDecoration(
                labelText: 'Add todo',
                hintText: 'Add todo',
              ),
            ),
          ),
        ),
        GestureDetector(
            onTap: (){
              bloc.event.add(AddTodoEvent(txtController.text));
            },
            child: const Icon(Icons.add)),
        const SizedBox(width: 10,)
      ],
    );
  }
}
