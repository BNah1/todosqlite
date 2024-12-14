import 'dart:async';
import 'dart:math';

import 'package:todosqlite/todo/base/base_bloc.dart';
import 'package:todosqlite/todo/base/base_event.dart';
import 'package:todosqlite/todo/database/todo_table.dart';
import 'package:todosqlite/todo/event/add_todo_event.dart';
import 'package:todosqlite/todo/event/delete_todo_event.dart';
import 'package:todosqlite/todo/model/todo.dart';

class TodoBloc extends BaseBloc{
  StreamController<List<Todo>> _streamController = StreamController<List<Todo>>();
  Stream<List<Todo>> get todoListSream => _streamController.stream;
  final _random = Random();
  TodoTable _todoTable = TodoTable();

  List<Todo> _todoListData = [];

  _addTodo(Todo todo) async {
    //insert to database
    await _todoTable.insertTodo(todo);

    _todoListData.add(todo);
    _streamController.sink.add(_todoListData);
  }

  _deleteTodo(Todo todo) async {
    //delete to database
    await _todoTable.deleteTodo(todo);

    _todoListData.remove(todo);
    _streamController.sink.add(_todoListData);
  }

  initData() async {
    _todoListData = await _todoTable.selectAllTodo();
    if(_todoListData == null){
      return;
    }
    _streamController.sink.add(_todoListData);
  }

  @override
  void dispatchEvent(BaseEvent event) {
    if(event is AddTodoEvent){
      Todo todo = Todo.fromData(_random.nextInt(100), event.content);
      _addTodo(todo);
    } else if (event is DeleteTodoEvent){
      _deleteTodo(event.todo);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _streamController.close();
    super.dispose();
  }

}