import 'package:flutter/material.dart';
import 'package:my_karaoke_new_sql/db/db_helper_cate.dart';
import '../datas/song_item_category.dart';

class MySongCategoryProviderModel extends ChangeNotifier {
  List<SongItemCategory> _myItems = [];
  List<SongItemCategory> get myItems => _myItems;
  set myItems(List<SongItemCategory> val) {
    _myItems = val;
    notifyListeners();
  }

  void getAllSongs() {
    showData();
    notifyListeners();
  }

  void editItem(SongItemCategory val, int idx) {
    _myItems[idx] = val;
    notifyListeners();
  }

  void addItem(SongItemCategory val) {
    _myItems.add(val);
    // print(myItems);
    notifyListeners();
  }

  void delItem(int val) {
    _myItems.removeAt(val);
    notifyListeners();
  }

  Future showData() async {
    DbHelperCategory helper = DbHelperCategory();
    List<SongItemCategory> songList;
    await helper.openDbCategory();
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
