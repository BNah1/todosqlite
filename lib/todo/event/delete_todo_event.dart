import 'package:todosqlite/todo/base/base_event.dart';
import 'package:todosqlite/todo/model/todo.dart';

class DeleteTodoEvent extends BaseEvent {
  Todo todo;
  DeleteTodoEvent(this.todo);
}