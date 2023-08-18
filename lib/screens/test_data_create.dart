import 'package:flutter/material.dart';
import '../datas/song_item.dart';
import '../db/db_helper.dart';

class TestDataCreate extends StatelessWidget {
  const TestDataCreate({super.key});
  final String _songFavorite = "false";
  final String _songJanre = "발라드";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('새 노래 추가'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                makeTestData();
              },
              child: const Text(
                'Test SQL Create 30 piece',
                style: TextStyle(fontSize: 20),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                deleteTestData();
              },
              child: const Text(
                'Test SQL all delete',
                style: TextStyle(fontSize: 20),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                deleteTestDatabase();
              },
              child: const Text(
                'Test SQL database 지우기',
                style: TextStyle(fontSize: 20),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                deleteTestTable();
              },
              child: const Text(
                'Test SQL Table 지우기',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void deleteTestDatabase() async {
    try {
      DbHelper helper = DbHelper();
      await helper.openDb();
      await helper.db!.rawQuery("drop database if exists mysongs");
    } catch (e) {
      print(e);
    }
  }

  void deleteTestTable() async {
    try {
      DbHelper helper = DbHelper();
      await helper.openDb();
      await helper.db!.rawQuery("drop table if exists mysongs");
    } catch (e) {
      print(e);
    }
  }

  void deleteTestData() async {
    try {
      DbHelper helper = DbHelper();
      await helper.openDb();
      var result = await helper.deleteAllList();
      if (result == 'success') print("Success");
    } catch (e) {
      print(e);
    }
  }

  void makeTestData() async {
    int cnt = 1;

    try {
      DbHelper helper = DbHelper();
      await helper.openDb();
      for (int i = 0; i < 30; i++) {
        final song =
            SongItem(null, 'Song item ${cnt++}', _songJanre, _songFavorite);
        await helper.insertList(song);
        // print('success');
      }
    } catch (e) {
      print(e);
    }
  }
}
