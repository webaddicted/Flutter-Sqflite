import 'package:fluttersqflite/global/constant/db_constant.dart';
import 'package:fluttersqflite/model/db/user_table.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  // make this a singleton class
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper dbHelper = DatabaseHelper._privateConstructor();
  // only have a single app-wide reference to the database
  static Database _db;

  Future<Database> get database async {
    if (_db == null) _db = await _initDb();
    return _db;
  }

  _initDb() async {
//    Directory documentsDirectory = await getApplicationDocumentsDirectory();
//    String path = join(documentsDirectory.path, _databaseName);
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, DbConstant.DB_NAME);
    return await openDatabase(path,
        version: DbConstant.DB_VERSION, onCreate: _onCreate);
  }
  Future _onCreate(Database db, int version) async {
    await db.execute(UserTable.USER_TABLE_QUERY);
//    await db.execute(SqfliteUserInfo.USER_TABLE_QUERY);
  }
}
