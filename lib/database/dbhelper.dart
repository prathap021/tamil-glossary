import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:tamil_glossary/model/wordsdb_model.dart';

class DBProvider {
  static Database? _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database> get database async {
    // If database exists, return database
    if (_database != null) return _database!;

    // If database don't exists, create one
    _database = await initDB();

    return _database!;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'wordsdb.db');

    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute('CREATE TABLE wordsdb('
          'id INTEGER PRIMARY KEY,'
          'title TEXT,'
          'description TEXT'
          ')');
    });
  }

  //savewords
  savewords(WordsDb wordsDb) async {
    //await deleteAllDenomination();
    final db = await database;
    final res = await db.insert('wordsDb', wordsDb.toJson());

    return res;
  }

  // remove words
  Future<int> deleteAllWords() async {
    final db = await database;
    final res = await db.rawDelete('DELETE FROM wordsDb');

    return res;
  }
  //delete perticular worlds

  delete(String name) async {
    final db = await database;

    return await db.delete(
      'wordsDb',
      where: "title = ?",
      whereArgs: [name],
    );
  }

  Future<bool> query(String queryword) async {
    final db = await database;

    List<Map> result =
        await db.rawQuery('SELECT * FROM wordsDb WHERE title=?', [queryword]);
    var res = result.any((element) => element.containsValue(queryword));
    print(res);
    return res;
  }

  //get words
  Future<List<WordsDb>> getAllWords() async {
    final db = await database;
    final res = await db.rawQuery("SELECT * FROM wordsDb");

    List<WordsDb> list =
        res.isNotEmpty ? res.map((c) => WordsDb.fromJson(c)).toList() : [];

    return list;
  }
}
