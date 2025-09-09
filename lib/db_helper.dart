import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static final DBHelper _instance = DBHelper._internal();
  factory DBHelper() => _instance;
  DBHelper._internal();

  static Database? _db;

  Future<Database> get db async {
    if (_db != null) return _db!;
    _db = await _initDB();
    return _db!;
  }

  Future<Database> _initDB() async {
    final path = join(await getDatabasesPath(), 'stories.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE stories(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            content TEXT,
            founder TEXT,
            product TEXT,
            link TEXT,
            image TEXT
          )
        ''');
      },
    );
  }

  Future<int> insertStory(Map<String, dynamic> story) async {
    final dbClient = await db;
    return await dbClient.insert('stories', story);
  }

  Future<List<Map<String, dynamic>>> getStories() async {
    final dbClient = await db;
    return await dbClient.query('stories');
  }

  Future<int> deleteStory(int id) async {
    final dbClient = await db;
    return await dbClient.delete('stories', where: 'id = ?', whereArgs: [id]);
  }
}
