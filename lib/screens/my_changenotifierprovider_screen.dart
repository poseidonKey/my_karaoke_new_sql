import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../datas/my_data.dart';
import '../providers/my_changenotifier_provider.dart';
import 'my_changenotifierprovider_edit_screen.dart';

class MyChangeNotifierProviderScreen extends StatelessWidget {
  const MyChangeNotifierProviderScreen({super.key});
  static int count = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Notifier Provider'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const MyChangeNotifierProviderEditScreen(
                    choiceItem: 1,
                  ),
                ),
              );
            },
            icon: const Icon(Icons.breakfast_dining),
          )
        ],
      ),
      body: Center(
        child: Consumer<MyChangeNotifierProviderModel>(
          builder: (context, myCnprovider, child) {
            return ListView.builder(
              itemBuilder: (context, index) {
                return ListTile(
                  title: GestureDetector(
                    child: Text(myCnprovider.myItems[index].mData),
                    onTap: () async {
                      var result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => MyChangeNotifierProviderEditScreen(
                            choiceItem: index,
                          ),
                        ),
                      );
                      // print('result : $result');
                      if (result != null) {
                        MyData val = myCnprovider.myItems[index];
                        val.mData = '${val.mData}--- $result';
                        myCnprovider.editItem(val, index);
                      }
                    },
                  ),
                  leading: IconButton(
                    onPressed: () {
                      myCnprovider.delItem(index);
                    },
                    icon: const Icon(Icons.delete),
                  ),
                  trailing: IconButton(
                      onPressed: () {
                        myCnprovider.favChange(index);
                        // myCnprovider.myItems[index].isFave =
                        //     !myCnprovider.myItems[index].isFave;
                        // print(myCnprovider.myItems[index].isFave);
                      },
                      icon: myCnprovider.myItems[index].isFave
                          ? const Icon(
                              Icons.favorite_border,
                              color: Colors.red,
                            )
                          : const Icon(Icons.favorite_border_outlined)),
                );
              },
              itemCount: myCnprovider.myItems.length,
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final myCnModel = Provider.of<MyChangeNotifierProviderModel>(context,
              listen: false);
          myCnModel.addItem(
            MyData(mData: "Item ${++count}"),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
