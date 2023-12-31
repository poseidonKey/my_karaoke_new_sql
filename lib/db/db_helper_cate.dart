import 'package:my_karaoke_new_sql/datas/song_item_category.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHelperCategory {
  final int version = 1;
  Database? dbCate;

  static final DbHelperCategory _dbHelperCategory =
      DbHelperCategory._internal();
  DbHelperCategory._internal();
  factory DbHelperCategory() {
    return _dbHelperCategory;
  }
  Future<Database> openDbCategory() async {
    dbCate ??=
        await openDatabase(join(await getDatabasesPath(), 'mysongscate.db'),
            onCreate: (database, version) {
      database.execute(
          'CREATE TABLE mysongscategory(id INTEGER PRIMARY KEY, songJanreCate text )');
    }, version: version);
    return dbCate!;
  }

  Future<List<SongItemCategory>> getLists() async {
    final List<Map<String, dynamic>> maps =
        await dbCate!.query('mysongscategory');
    if (maps.isEmpty) {
      return [];
    }

    return List.generate(maps.length, (i) {
      return SongItemCategory(
          maps[i]["id"].toString(), maps[i]["songJanreCate"]);
    });
  }

  Future<int> insertList(SongItemCategory list) async {
    int id = await dbCate!.insert(
      'mysongscategory',
      list.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return id;
  }

  Future<int> deleteList(SongItemCategory list) async {
    int id = await dbCate!
        .delete("mysongscategory", where: "id = ?", whereArgs: [list.id]);
    return id;
  }

  Future<void> changeSongName(SongItemCategory list, String val) async {
    await dbCate!.rawUpdate(
        "update mysongscategory set songJanreCate='$val' where id=${list.id}");
  }

  Future<String> deleteAllList() async {
    await dbCate!.delete("mysongscategory");
    return 'delete success';
  }

  Future<List<SongItemCategory>> searchList(
      String searchTerm, String target) async {
    String query =
        "select * from mysongscategory where $target like '%$searchTerm%'";
    final List<Map<String, dynamic>> maps = await dbCate!.rawQuery(query);
    return maps
        .map(
          (e) => SongItemCategory(e["id"].toString(), e["songJanreCate"]),
        )
        .toList();
  }
}
