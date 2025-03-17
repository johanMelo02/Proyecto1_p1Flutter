import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'person.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database? _database;

  DatabaseHelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'people_and_scores.db'); // Cambié el nombre de la base de datos
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  // Método que crea las dos tablas en la base de datos
  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE people (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        age INTEGER NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE scores (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        score INTEGER NOT NULL
      )
    ''');
  }

  // Método para insertar un puntaje en la tabla scores (Práctica 6)
  Future<void> insertScore(int score) async {
    final db = await database;
    await db.insert('scores', {'score': score});
  }

  // Método para obtener los 5 mejores puntajes (Práctica 6)
  Future<List<int>> getTop5Scores() async {
    final db = await database;
    final result = await db.query(
      'scores',
      orderBy: 'score DESC',
      limit: 5,
    );
    return result.map((e) => e['score'] as int).toList();
  }

  // Método para insertar una persona en la tabla people (Práctica 5)
  Future<void> insertPerson(Person person) async {
    final db = await database;
    await db.insert('people', person.toMap());
  }

  // Método para obtener todas las personas de la tabla people (Práctica 5)
  Future<List<Person>> getPeople() async {
    final db = await database;
    final people = await db.query('people');
    return people.map((p) => Person.fromMap(p)).toList();
  }

  // Método para eliminar la base de datos (opcional para debug)
  Future<void> deleteDatabase(String path) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'people_and_scores.db');
    await deleteDatabase(path);
  }
}
