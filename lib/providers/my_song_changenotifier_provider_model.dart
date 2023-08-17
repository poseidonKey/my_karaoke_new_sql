import 'package:flutter/material.dart';
import '../datas/song_item.dart';
import '../db/db_helper.dart';

class MySongChangeNotifierProviderModel extends ChangeNotifier {
  List<SongItem> _myItems = [];
  List<SongItem> get myItems => _myItems;
  set myItems(List<SongItem> val) {
    _myItems = val;
    notifyListeners();
  }

  void getAllSongs() {
    showData();
    notifyListeners();
  }

  void favChange(int val) {
    _myItems[val].songFavorite = (_myItems[val].songFavorite == 'true')
        ? _myItems[val].songFavorite = 'false'
        : _myItems[val].songFavorite = 'true';
    notifyListeners();
  }

  void editItem(SongItem val, int idx) {
    _myItems[idx] = val;
    notifyListeners();
  }

  void addItem(SongItem val) {
    _myItems.add(val);
    // print(myItems);
    notifyListeners();
  }

  void delItem(int val) {
    _myItems.removeAt(val);
    notifyListeners();
  }

  Future showData() async {
    DbHelper helper = DbHelper();
    List<SongItem> songList;
    await helper.openDb();
    songList = await helper.getLists();
    if (songList.isEmpty) {
      songList = [];
    } else {
      songList = songList;
    }
    // print(songList);
    myItems = songList;
    // _myItems.addAll(songList);
  }
}
