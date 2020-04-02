import 'dart:async';
import 'dart:developer';
import 'package:farm_expense_management/common/database_manager/database_model.dart';
import 'package:farm_expense_management/common/models/expenses.dart';
import 'package:farm_expense_management/common/models/fields.dart';
import 'package:farm_expense_management/common/models/loan_item.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
 

class DatabaseManager {
  static final defaultManager = DatabaseManager();
  static Database _database;

  Map<Type, DatabaseTable> _tables = {
    Expense: ExpenseTable(),
    Field: FieldTable(),
    LoanItem: LoanTable()
  };

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }

    _database = await _initDatabase();
    return _database;
  }

  Future<Database> _initDatabase() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, "expenses.db");

    var database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      log('Creating tables');

      for (var key in _tables.keys) {
        final table = _tables[key];
        final tableName = table.name;
        final tableQuery = table.createQueryColumns;
        final sql = 'CREATE TABLE $tableName ($tableQuery)';

        await db.execute(sql);
      }
    });
    return database;
  }

  Future<List<dynamic>> insert(List<DatabaseModel> models) async {
    var db = await database;
    var batch = db.batch();
    for (var model in models) {
      DatabaseTable table = _tables[model.runtimeType];
      if (table == null) {
        continue;
      }

      batch.insert(table.name, model.toMap());
    }
    return batch.commit(noResult: true);
  }

  Future<int> update(Type type,String primaryKey, var primaryValue, String secondaryKey ,  var secondaryValue) async {
    var db = await database;
    DatabaseTable table = _tables[type];
    if (table == null) {
      return 0;
    }
    var tableName=table.name;

    return db.rawUpdate('''
      UPDATE $tableName 
      SET $secondaryKey=?
      WHERE $primaryKey=?
      ''',
      [primaryValue,secondaryValue]
      );

  }

  Future<List<dynamic>> remove(List<DatabaseModel> models) async {
    var db = await database;
    var batch = db.batch();
    for (var model in models) {
      DatabaseTable table = _tables[model.runtimeType];
      if (table == null) {
        continue;
      }

      String tableName = table.name;
      String query = model.removeQuery();
      batch.rawDelete(
          'DELETE FROM $tableName WHERE $query', model.removeArgs());
    }
    return batch.commit(noResult: true);
  }

  Future<List<Map>> fetchAllEntriesOf(Type type) async {
    print('inside Fetching Entries'+type.toString());
    DatabaseTable table = _tables[type];

    if (table == null) {
      return [];
    }

    var db = await database;
    var maps = await db.query(table.name, columns: table.columns);
    return maps;
  }

  Future<List<Map>> fetchAllEntriesWithKey(Type type,String key, String value) async {
    DatabaseTable table = _tables[type];

    if (table == null) {
      return [];
    }

    String whereString=key+'=?';
    var db = await database;
    var maps = await db.query(table.name, where: whereString, whereArgs: [value] );
    return maps;
  }

  Future close() async {
    var db = await database;
    db.close();
  }
}
