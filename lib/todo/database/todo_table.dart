import 'package:sqflite/sqflite.dart';
import 'todo_database.dart';
import '../model/todo.dart';

class TodoTable {
  static const TABLE_NAME = 'todo';
  static const CREATE_TABLE_QUERY = '''
    CREATE TABLE $TABLE_NAME (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      content TEXT
    )
  ''';

  Future<int> insertTodo(Todo todo) async {
    try {
      final db = await TodoDatabase.instance.database;
      return await db.insert(TABLE_NAME, todo.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
    } catch (e) {
      print('Error inserting TODO: $e');
      return -1;
    }
  }

  Future<void> deleteTodo(Todo todo) async {
    final db = await TodoDatabase.instance.database;
    await db.delete(TABLE_NAME, where: 'id = ?', whereArgs: [todo.id]);
  }

  Future<List<Todo>> selectAllTodo() async {
    final db = await TodoDatabase.instance.database;
    final List<Map<String, dynamic>> maps = await db.query(TABLE_NAME);
    return List.generate(maps.length, (i) {
      return Todo.fromData(maps[i]['id'], maps[i]['content']);
    });
  }
}
