//db_provider class

import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';
import 'package:test1/model/note_model.dart';

class DatabaseProvider{
  DatabaseProvider._();
  static final DatabaseProvider db = DatabaseProvider._();
  static Database _database;

  //membuat getter database
  Future<Database> get database async{
    //cek jika kita belum punya db
    if (_database != null) {
      return _database;
    }
    _database = await initDB();
    return _database;
  }

  initDB() async{
    return await openDatabase(join(await getDatabasesPath(), "note_app.db"),
    onCreate: (db, version) async {
      //membuat tabel pertama
      await db.execute('''
      CREATE TABLE notes (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        body TEXT,
        creation_date DATE
      )
      ''');
    },
    version : 1
    );
  }
  //MEMBUAT FUNGSI PENAMBAHAN NOTE
  addNewNote(NoteModel note)async{
    final db = await database;
    db.insert("notes", note.toMap(),conflictAlgorithm: ConflictAlgorithm.replace);
  }
  //MEMBUAT FUNGSI YANG MENGAMBIL DATABASE DAN MENGEMBALIKANNYA KE DALAM NOTE
  Future<dynamic> getNotes()async{
    final db = await database;
    var res = await db.query("notes");
    if(res.length == 0){
      return Null;
    }else {
      var resultMap =  res.toList();
      return resultMap.isNotEmpty ? resultMap : Null;
    }
  }

  Future<int> deleteNote(int id) async{
    final db = await database;
    int count = await db.rawDelete("DELETE FROM notes WHERE id = ?",[id]);
    return count;//mengembalikan berapa jumlah row yang dihapus
  }


}