import 'package:flutter/material.dart';
import 'package:my_karaoke_new_sql/providers/my_song_search_provider_model.dart';
import 'package:my_karaoke_new_sql/screens/my_song_favority_screen.dart';
import 'package:provider/provider.dart';
import '../db/db_helper.dart';

class MySongFavorityEditScreen extends StatelessWidget {
  final int choiceItem;
  const MySongFavorityEditScreen({super.key, required this.choiceItem});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favority Edit '),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.breakfast_dining),
          )
        ],
      ),
      body: Center(
        child: Consumer<MySongSearchProviderModel>(
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
                        var app = Provider.of<MySongSearchProviderModel>(
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
                    print(choiceItem);
                    DbHelper helper = DbHelper();
                    await helper.openDb();
                    await helper.deleteList(myCnprovider.myItems[choiceItem]);
                    var app = Provider.of<MySongSearchProviderModel>(context,
                        listen: false);
                    app.getAllSongs();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MySongFavorityScreen(
                            janreData: 'true', janre: 'songFavorite'),
                      ),
                    );
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
