import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/evaluation_record.dart';

class LocalDatabase {
  static const _databaseName = 'risk_assessment.db';
  static const _databaseVersion = 1;
  static const tableEvaluations = 'evaluations';

  static Database? _database;

  LocalDatabase._();
  static final LocalDatabase instance = LocalDatabase._();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $tableEvaluations(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        anonymous INTEGER NOT NULL,
        respondentName TEXT NOT NULL,
        completedAt TEXT NOT NULL,
        score INTEGER NOT NULL,
        riskLevel TEXT NOT NULL,
        answeredQuestions INTEGER NOT NULL,
        summary TEXT NOT NULL
      )
    ''');
  }

  Future<int> insertEvaluation(EvaluationRecord record) async {
    final db = await database;
    return await db.insert(tableEvaluations, record.toMap());
  }

  Future<List<EvaluationRecord>> fetchEvaluations() async {
    final db = await database;
    final rows = await db.query(
      tableEvaluations,
      orderBy: 'completedAt DESC',
    );
    return rows.map((row) => EvaluationRecord.fromMap(row)).toList();
  }
}
