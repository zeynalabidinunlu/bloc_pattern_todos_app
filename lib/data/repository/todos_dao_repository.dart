import 'package:bloc_pattern_todos_app/data/entity/todos.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class TodosDaoRepository {
  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    String path = join(await getDatabasesPath(), 'todos.db');
    return openDatabase(
      path,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE todos(id INTEGER PRIMARY KEY, title TEXT, description TEXT, isDone INTEGER)',
        );
      },
      version: 1,
    );
  }

  Future<void> todosSave(String title, String description, int id, bool isDone) async {
    final db = await database;
    await db.insert(
      'todos',
      {
        'id': id,
        'title': title,
        'description': description,
        'isDone': isDone ? 1 : 0
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    print("Görev Kaydet : $title - $description - $id - $isDone");
  }

  Future<void> guncelle(String title, String description, int id, bool isDone) async {
    final db = await database;
    await db.update(
      'todos',
      {
        'title': title,
        'description': description,
        'isDone': isDone ? 1 : 0
      },
      where: 'id = ?',
      whereArgs: [id],
    );
    print("Görev Güncelle : $title - $description - $id - $isDone");
  }

  Future<List<Todos>> gorevleriYukle() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('todos');

    return List.generate(maps.length, (i) {
      return Todos(
        id: maps[i]['id'],
        title: maps[i]['title'],
        description: maps[i]['description'],
        isDone: maps[i]['isDone'] == 1,
      );
    });
  }

  Future<List<Todos>> ara(String aramaKelimesi) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'todos',
      where: 'title LIKE ? OR description LIKE ?',
      whereArgs: ['%$aramaKelimesi%', '%$aramaKelimesi%'],
    );

    return List.generate(maps.length, (i) {
      return Todos(
        id: maps[i]['id'],
        title: maps[i]['title'],
        description: maps[i]['description'],
        isDone: maps[i]['isDone'] == 1,
      );
    });
  }

  Future<void> sil(int id) async {
    final db = await database;
    await db.delete(
      'todos',
      where: 'id = ?',
      whereArgs: [id],
    );
    print("Görev Sil : $id");
  }
}
