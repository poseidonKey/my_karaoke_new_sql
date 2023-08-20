import 'package:flutter/material.dart';
import 'package:my_karaoke_new_sql/datas/song_item_category.dart';
import 'package:my_karaoke_new_sql/db/db_helper_cate.dart';
import 'package:my_karaoke_new_sql/providers/my_song_category_provider_model%20.dart';
import 'package:my_karaoke_new_sql/providers/my_song_search_provider_model.dart';
import 'package:my_karaoke_new_sql/screens/songs_list_screen.dart';
import 'package:provider/provider.dart';
import 'my_song_changenotifierprovider_edit_screen.dart';

class MySongJanreCategoryScreen extends StatefulWidget {
  const MySongJanreCategoryScreen({
    super.key,
  });

  @override
  State<MySongJanreCategoryScreen> createState() =>
      _MySongJanreCategoryScreenState();
}

class _MySongJanreCategoryScreenState extends State<MySongJanreCategoryScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      DbHelperCategory helper = DbHelperCategory();
      await helper.openDbCategory();
      Provider.of<MySongCategoryProviderModel>(context, listen: false)
          .getAllSongs();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Janre Category"),
      ),
      body: Consumer<MySongCategoryProviderModel>(
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
                        child:
                            Text(mySongCnprovider.myItems[index].songJanreCate),
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
                            SongItemCategory val =
                                mySongCnprovider.myItems[index];
                            val.songJanreCate =
                                '${val.songJanreCate}--- $result';
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
