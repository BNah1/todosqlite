import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todosqlite/todo/bloc/todo_bloc.dart';
import 'package:todosqlite/todo/event/delete_todo_event.dart';

import '../model/todo.dart';

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    var bloc = Provider.of<TodoBloc>(context);
    bloc.initData();
  }

  @override
  Widget build(BuildContext context) {
    var bloc = Provider.of<TodoBloc>(context);
    return StreamBuilder<List<Todo>>(
      stream: bloc.todoListSream,
      builder: (context, snapshot) {
        switch(snapshot.connectionState){
          case ConnectionState.active :
            return
            ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(snapshot.data![index].content ),
                    trailing: GestureDetector(
                      onTap: () {
                        bloc.event.add(DeleteTodoEvent(snapshot.data![index]));
                      },
                      child: const Icon(Icons.delete),
                    ),
                  );
                });
          case ConnectionState.waiting :
            return Center(child: Text('empty'),);
          case ConnectionState.none :
            default:
              return Center(
                child: Container(
                    height: 80,
                    width: 80,
                    child: CircularProgressIndicator()),
              );
        }
        }
    );
  }
}
