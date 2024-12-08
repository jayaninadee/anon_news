import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static final DBHelper _instance = DBHelper._internal();
  factory DBHelper() => _instance;

  late Database _database;

  DBHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDB();
    return _database;
  }

  // Initialize the database
  Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), 'feedbacks.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE feedbacks(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            content TEXT,
            author TEXT
          )
        ''');
      },
    );
  }

  // Create a new feedback
  Future<void> insertFeedback(Map<String, String> feedback) async {
    final db = await database;
    await db.insert(
      'feedbacks',
      feedback,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Get all feedback
  Future<List<Map<String, dynamic>>> getFeedbacks() async {
    final db = await database;
    return await db.query('feedbacks');
  }

  // Update feedback
  Future<void> updateFeedback(int id, String newContent) async {
    final db = await database;
    await db.update(
      'feedbacks',
      {'content': newContent},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Delete feedback
  Future<void> deleteFeedback(int id) async {
    final db = await database;
    await db.delete(
      'feedbacks',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}