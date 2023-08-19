import 'package:flutter/material.dart';
import 'package:my_karaoke_new_sql/providers/my_song_search_provider_model.dart';
import 'package:my_karaoke_new_sql/screens/songs_list_screen.dart';
import 'package:provider/provider.dart';
import '../datas/song_item.dart';
import '../db/db_helper.dart';
import 'my_song_changenotifierprovider_edit_screen.dart';

class MySongJanreScreen extends StatefulWidget {
  final String janre;
  final String janreData;
  const MySongJanreScreen({
    super.key,
    required this.janreData,
    required this.janre,
  });

  @override
  State<MySongJanreScreen> createState() => _MySongJanreScreenState();
}

class _MySongJanreScreenState extends State<MySongJanreScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      DbHelper helper = DbHelper();
      await helper.openDb();
      Provider.of<MySongSearchProviderModel>(context, listen: false)
          .getSearchSongs(widget.janreData, widget.janre);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Janre"),
      ),
      body: Consumer<MySongSearchProviderModel>(
        builder: (context, mySongCnprovider, child) {
          return Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  Provider.of<MySongSearchProviderModel>(context, listen: false)
                      .myItems = [];
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SongsListScreen(),
                    ),
                  );
                },
                child: const Text('Back'),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: mySongCnprovider.myItems.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: GestureDetector(
                        child: Text(
                            '${mySongCnprovider.myItems[index].songName} -- ${mySongCnprovider.myItems[index].songJanre}'),
                        onTap: () async {
                          var result = await Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  MySongChangeNotifierProviderEditScreen(
                                choiceItem: int.parse(
                                    mySongCnprovider.myItems[index].id!),
                              ),
                            ),
                          );
                          // print('result : $result');
                          if (result != null) {
                            SongItem val = mySongCnprovider.myItems[index];
                            val.songName = '${val.songName}--- $result';
                            mySongCnprovider.editItem(
                              val,
                              int.parse(mySongCnprovider.myItems[index].id!),
                            );
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
                        icon: (mySongCnprovider.myItems[index].songFavorite ==
                                'true')
                            ? const Icon(
                                Icons.favorite_border,
                                color: Colors.red,
                              )
                            : const Icon(Icons.favorite_border_outlined),
                        onPressed: () async {
                          mySongCnprovider.favChange(index);
                          DbHelper helper = DbHelper();
                          await helper.openDb();
                          await helper.changeFavority(
                              mySongCnprovider.myItems[index],
                              mySongCnprovider.myItems[index].songFavorite);
                          var app = Provider.of<MySongSearchProviderModel>(
                              context,
                              listen: false);
                          app.getAllSongs();
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
