import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('user.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE user (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_code TEXT,
        display_name TEXT,
        email TEXT,
        employee_code TEXT,
        company_code TEXT
      )
    ''');
  }

  Future<void> insertUser(Map<String, dynamic> userData) async {
    final db = await instance.database;
    await db.insert('user', userData);
  }

  Future<void> _saveUserData(Map<String, dynamic> userData) async {
  final db = DatabaseHelper.instance;
  await db.insertUser({
    "user_code": userData["User_Code"],
    "display_name": userData["User_Display_Name"],
    "email": userData["Email"],
    "employee_code": userData["User_Employee_Code"],
    "company_code": userData["Company_Code"],
  });
}

}
