import 'package:flutter/material.dart';

import '../datas/my_data.dart';

class MyChangeNotifierProviderModel with ChangeNotifier {
  final List<MyData> _myItems = [];
  List<MyData> get myItems => _myItems;
  void favChange(int val) {
    _myItems[val].isFave = !_myItems[val].isFave;
    notifyListeners();
  }

  void editItem(MyData val, int idx) {
    _myItems[idx] = val;
    notifyListeners();
  }

  void addItem(MyData val) {
    _myItems.add(val);
    // print(myItems);
    notifyListeners();
  }

  void delItem(int val) {
    _myItems.removeAt(val);
    notifyListeners();
  }
}
