import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../db/db_helper.dart';
import '../providers/my_song_changenotifier_provider_model.dart';

class MySongChangeNotifierProviderEditScreen extends StatelessWidget {
  final int choiceItem;
  const MySongChangeNotifierProviderEditScreen(
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
        child: Consumer<MySongChangeNotifierProviderModel>(
          builder: (context, myCnprovider, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('data : ${myCnprovider.myItems[choiceItem].songName}'),
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
                      onPressed: () async {
                        DbHelper helper = DbHelper();
                        await helper.openDb();
                        await helper.changeSongName(
                            myCnprovider.myItems[choiceItem],
                            '${myCnprovider.myItems[choiceItem].songName}, hello');
                        var app =
                            Provider.of<MySongChangeNotifierProviderModel>(
                                context,
                                listen: false);
                        app.getAllSongs();
                        Navigator.pop(context, ', hello');
                      },
                      child: const Text('Edit..'),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () async {
                    DbHelper helper = DbHelper();
                    await helper.openDb();
                    await helper.deleteList(myCnprovider.myItems[choiceItem]);
                    var app = Provider.of<MySongChangeNotifierProviderModel>(
                        context,
                        listen: false);
                    app.getAllSongs();
                    Navigator.pop(context, ', hello');
                  },
                  child: const Text('Delete..'),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
