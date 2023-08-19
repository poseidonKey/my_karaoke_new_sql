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
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const TextStyle optionStyle1 =
      TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
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
            onPressed: () async {
              DbHelper helper = DbHelper();
              await helper.openDb();
              var t = SongItem(
                  null,
                  "append item",
                  "songGYNumber",
                  "songTJNumber",
                  '발라드',
                  "songUtubeAddress",
                  "songETC",
                  "2022.1.1",
                  "false");
              await helper.insertList(t);
              var app = Provider.of<MySongChangeNotifierProviderModel>(context,
                  listen: false);
              app.getAllSongs();
            },
            icon: const Icon(Icons.add_task_outlined),
          )
        ],
      ),
      drawer: Drawer(
        width: MediaQuery.of(context).size.width * .5,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                '애창곡 jangre',
                style: optionStyle,
              ),
            ),
            ListTile(
              title: const Text(
                '발라드',
                style: optionStyle1,
              ),
              onTap: () {
                print(Janre.BALLADE);
              },
            ),
            ListTile(
              title: const Text(
                '댄스',
                style: optionStyle1,
              ),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: const Text(
                '트로트',
                style: optionStyle1,
              ),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: const Text(
                '팝',
                style: optionStyle1,
              ),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: const Text(
                '클래식',
                style: optionStyle1,
              ),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
          ],
        ),
      ),
      body: Consumer<MySongChangeNotifierProviderModel>(
        builder: (context, mySongCnprovider, child) {
          return ListView.separated(
            itemCount: mySongCnprovider.myItems.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: GestureDetector(
                  child: Text(
                      '${mySongCnprovider.myItems[index].songName} -- ${mySongCnprovider.myItems[index].songJanre}'),
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
                  radius: 15,
                  foregroundColor: Colors.deepPurpleAccent,
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
                    var app = Provider.of<MySongChangeNotifierProviderModel>(
                        context,
                        listen: false);
                    app.getAllSongs();
                  },
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) => SizedBox(
              height: 5,
              child: Container(
                color: Colors.grey.shade300,
                width: 100,
              ),
            ),
          );
        },
      ),
    );
  }
}
