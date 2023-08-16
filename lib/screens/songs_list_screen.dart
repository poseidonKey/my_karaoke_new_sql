import 'package:flutter/material.dart';
import 'package:my_karaoke_new_sql/providers/my_song_changenotifier_provider_model.dart';
import 'package:provider/provider.dart';

class SongsListScreen extends StatelessWidget {
  const SongsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sqflite"),
      ),
      body: Consumer<MySongChangeNotifierProviderModel>(
        builder: (context, mySongCnprovider, child) {
          return ListView.builder(
            itemCount: mySongCnprovider.myItems.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(mySongCnprovider.myItems[index].songName),
                // title:Text(songItemController.songItem.value.songName),
                leading: CircleAvatar(
                  child: Text(
                    mySongCnprovider.myItems[index].id.toString(),
                    // songItemController.songItem.value.id.toString(),
                  ),
                ),
                trailing: IconButton(
                  icon: (mySongCnprovider.myItems[index].songFavorite == 'true')
                      ? const Icon(
                          Icons.favorite_border,
                          color: Colors.red,
                        )
                      : const Icon(Icons.favorite_border_outlined),
                  onPressed: () {
                    mySongCnprovider.favChange(index);
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          var song = Provider.of<MySongChangeNotifierProviderModel>(context,
              listen: false);
          song.getAllSongs();
        },
        child: const Text('Load'),
      ),
    );
  }
}
