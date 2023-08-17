import 'package:flutter/material.dart';
import 'package:my_karaoke_new_sql/datas/song_item.dart';
import 'package:my_karaoke_new_sql/providers/my_song_changenotifier_provider_model.dart';
import 'package:provider/provider.dart';
import '../db/db_helper.dart';
import 'my_song_changenotifierprovider_edit_screen.dart';

class SongsListScreen extends StatefulWidget {
  const SongsListScreen({super.key});

  @override
  State<SongsListScreen> createState() => _SongsListScreenState();
}

class _SongsListScreenState extends State<SongsListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<MySongChangeNotifierProviderModel>(context, listen: false)
          .getAllSongs();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sqflite"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.sports_basketball),
          )
        ],
      ),
      body: Consumer<MySongChangeNotifierProviderModel>(
        builder: (context, mySongCnprovider, child) {
          return ListView.builder(
            itemCount: mySongCnprovider.myItems.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                // title: Text(mySongCnprovider.myItems[index].songName),
                title: GestureDetector(
                  child: Text(mySongCnprovider.myItems[index].songName),
                  onTap: () async {
                    var result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => MySongChangeNotifierProviderEditScreen(
                          choiceItem: index,
                        ),
                      ),
                    );
                    // print('result : $result');
                    if (result != null) {
                      SongItem val = mySongCnprovider.myItems[index];
                      val.songName = '${val.songName}--- $result';
                      mySongCnprovider.editItem(val, index);
                    }
                  },
                ),
                leading: CircleAvatar(
                  child: Text(
                    mySongCnprovider.myItems[index].id.toString(),
                  ),
                ),
                trailing: IconButton(
                  icon: (mySongCnprovider.myItems[index].songFavorite == 'true')
                      ? const Icon(
                          Icons.favorite_border,
                          color: Colors.red,
                        )
                      : const Icon(Icons.favorite_border_outlined),
                  onPressed: () async {
                    mySongCnprovider.favChange(index);
                    DbHelper helper = DbHelper();
                    await helper.openDb();
                    await helper.changeFavority(mySongCnprovider.myItems[index],
                        mySongCnprovider.myItems[index].songFavorite);
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          DbHelper helper = DbHelper();
          await helper.openDb();
          var t = SongItem(null, 'append item', 'false');
          await helper.insertList(t);
          var app = Provider.of<MySongChangeNotifierProviderModel>(context,
              listen: false);
          app.getAllSongs();
        },
        child: const Text('Append'),
      ),
    );
  }
}
