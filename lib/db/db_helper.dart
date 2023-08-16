import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../datas/song_item.dart';

class DbHelper {
  final int version = 1;
  Database? db;

  static final DbHelper _dbHelper = DbHelper._internal();
  DbHelper._internal();
  factory DbHelper() {
    return _dbHelper;
  }
  Future<Database> openDb() async {
    db ??= await openDatabase(join(await getDatabasesPath(), 'mysongs.db'),
        onCreate: (database, version) {
      database.execute(
          'CREATE TABLE mysongs(id INTEGER PRIMARY KEY, songName TEXT, songFavorite text)');
    }, version: version);
    return db!;
  }

  Future<List<SongItem>> getLists() async {
    final List<Map<String, dynamic>> maps = await db!.query('mysongs');
    if (maps.isEmpty) {
      return [];
    }

    return List.generate(maps.length, (i) {
      return SongItem(maps[i]["id"].toString(), maps[i]["songName"],
          maps[i]["songFavorite"]);
    });
  }

  Future<int> insertList(SongItem list) async {
    int id = await db!.insert(
      'mysongs',
      list.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return id;
  }

  Future<int> deleteList(SongItem list) async {
    int id = await db!.delete("mysongs", where: "id = ?", whereArgs: [list.id]);
    return id;
  }

  Future<String> deleteAllList() async {
    await db!.delete("mysongs");
    return 'delete success';
  }

  Future<List<SongItem>> searchList(String searchTerm) async {
    String query = "select * from mysongs where songName like '%$searchTerm%'";
    final List<Map<String, dynamic>> maps = await db!.rawQuery(query);
    return maps
        .map(
          (e) => SongItem(e["id"].toString(), e["songName"], e["songFavorite"]),
        )
        .toList();
  }
}
