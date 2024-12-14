import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'todo_table.dart';

class TodoDatabase {
  static const DB_NAME = 'todo.db';
  static const DB_VERSION = 1;
  static Database? _database;

  TodoDatabase._internal();
  static final TodoDatabase instance = TodoDatabase._internal();

  Future<Database> get database async {
    if (_database == null) {
      await init();
    }
    return _database!;
  }

  static const initScripts = [TodoTable.CREATE_TABLE_QUERY];
  static const migrationScripts = [];

  Future<void> init() async {
    _database = await openDatabase(
      join(await getDatabasesPath(), DB_NAME),
      version: DB_VERSION,
      onCreate: (db, version) async {
        for (var script in initScripts) {
          await db.execute(script);
        }
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        for (var script in migrationScripts) {
          await db.execute(script);
        }
      },
    );

    print('khoi dong databse~~~');
  }
}
