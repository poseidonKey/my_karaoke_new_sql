import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/my_changenotifier_provider.dart';

class MyChangeNotifierProviderEditScreen extends StatelessWidget {
  final int choiceItem;
  const MyChangeNotifierProviderEditScreen(
      {super.key, required this.choiceItem});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Provider'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.breakfast_dining),
          )
        ],
      ),
      body: Center(
        child: Consumer<MyChangeNotifierProviderModel>(
          builder: (context, myCnprovider, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('data : ${myCnprovider.myItems[choiceItem].mData}'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('back screen'),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context, 'hello');
                      },
                      child: const Text('Edit..'),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
