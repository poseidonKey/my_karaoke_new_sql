import 'package:flutter/material.dart';
import '../datas/song_item.dart';
import '../db/db_helper.dart';

class SongsListScreen extends StatefulWidget {
  const SongsListScreen({super.key});

  @override
  State<SongsListScreen> createState() => _SongsListScreenState();
}

class _SongsListScreenState extends State<SongsListScreen> {
  DbHelper helper = DbHelper();
  List<SongItem>? songList;
  @override
  void initState() {
    super.initState();
    showData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sqflite"),
      ),
      body: ListView.builder(
        itemCount: (songList != null) ? songList!.length : 0,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(songList![index].songName),
            // title:Text(songItemController.songItem.value.songName),
            leading: CircleAvatar(
              child: Text(
                songList![index].id.toString(),
                // songItemController.songItem.value.id.toString(),
              ),
            ),
            trailing: IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {},
            ),
          );
        },
      ),
    );
    // return Scaffold(
    //   body: ListView.builder(
    //     itemBuilder: (context, index) {
    //       return ListTile(
    //         title: Text('Item : $index'),
    //       );
    //     },
    //     itemCount: 30,
    //   ),
    // );
  }

  Future showData() async {
    await helper.openDb();
    songList = await helper.getLists();
    print(songList![0].songName);
    setState(() {
      songList = songList;
    });
  }
}
