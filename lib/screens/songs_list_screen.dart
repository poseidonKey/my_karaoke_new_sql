import 'package:flutter/material.dart';
import 'package:my_karaoke_new_sql/datas/song_item.dart';
import 'package:my_karaoke_new_sql/screens/my_song_append_screen.dart';
import 'package:my_karaoke_new_sql/screens/my_song_favority_screen.dart';
import 'package:my_karaoke_new_sql/providers/my_song_changenotifier_provider_model.dart';
import 'package:my_karaoke_new_sql/screens/my_song_janre_category_screen.dart';
import 'package:my_karaoke_new_sql/screens/my_song_janre_screen.dart';
import 'package:provider/provider.dart';
import '../db/db_helper.dart';
import 'my_song_changenotifierprovider_edit_screen.dart';
import 'my_song_search_screen.dart';

class SongsListScreen extends StatefulWidget {
  const SongsListScreen({super.key});
  // final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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

  // toggleDrawer() async {
  //   if (widget._scaffoldKey.currentState!.isDrawerOpen) {
  //     widget._scaffoldKey.currentState!.openEndDrawer();
  //   } else {
  //     widget._scaffoldKey.currentState!.openDrawer();
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sqflite"),
        actions: [
          const Text(
            '즐찾',
            style: TextStyle(
                fontSize: 15, color: Colors.red, fontWeight: FontWeight.bold),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const MySongFavorityScreen(
                      janreData: 'true', janre: 'songFavorite'),
                ),
              );
            },
            icon: const Icon(Icons.favorite),
          ),
          const Text(
            '곡찾기',
            style: TextStyle(
                fontSize: 15, color: Colors.red, fontWeight: FontWeight.bold),
          ),
          IconButton(
            onPressed: () async {
              var result = await Navigator.of(context).push(
                MaterialPageRoute(builder: (context) {
                  return const MySongSearchScreen();
                }),
              );
              if (result == "success") {
                var app = Provider.of<MySongChangeNotifierProviderModel>(
                    context,
                    listen: false);
                app.getAllSongs();
              }
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),
      drawer: _drawer(),
      body: Consumer<MySongChangeNotifierProviderModel>(
        builder: (context, mySongCnprovider, child) {
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    '총 곡수 : ${mySongCnprovider.myItems.length} 개',
                    style: const TextStyle(
                        color: Colors.lightBlue,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Row(
                    children: [
                      const Text(
                        '곡추가>>',
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.red,
                            fontWeight: FontWeight.w100),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MySongAppendScreen(),
                            ),
                          );
                        },
                        icon: const Icon(Icons.add_to_queue),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 5,
                child: Container(
                  color: Colors.grey,
                ),
              ),
              Expanded(
                child: ListView.separated(
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
                              builder: (_) =>
                                  MySongChangeNotifierProviderEditScreen(
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
                          var app =
                              Provider.of<MySongChangeNotifierProviderModel>(
                                  context,
                                  listen: false);
                          app.getAllSongs();
                        },
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      SizedBox(
                    height: 5,
                    child: Container(
                      color: Colors.grey.shade300,
                      width: 100,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _drawer() {
    return Drawer(
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
            onTap: () async {
              print(Janre.BALLADE);
              DbHelper helper = DbHelper();
              await helper.openDb();
              var result = await helper.searchList("발라드", "songJanre");
              for (var element in result) {
                print(element);
              }
            },
          ),
          ListTile(
            title: const Text(
              '댄스',
              style: optionStyle1,
            ),
            onTap: () async {
              DbHelper helper = DbHelper();
              await helper.openDb();
              var result = await helper.searchList("댄스", "songJanre");
              for (var element in result) {
                print(element);
              }
            },
          ),
          ListTile(
            title: const Text(
              '트로트',
              style: optionStyle1,
            ),
            onTap: () async {
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const MySongJanreScreen(
                    janreData: '트로트',
                    janre: 'songJanre',
                  ),
                ),
              );
            },
          ),
          ListTile(
            title: const Text(
              '팝',
              style: optionStyle1,
            ),
            onTap: () async {
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const MySongJanreScreen(
                    janreData: '팝',
                    janre: 'songJanre',
                  ),
                ),
              );
            },
          ),
          ListTile(
            title: const Text(
              '클래식',
              style: optionStyle1,
            ),
            onTap: () async {
              DbHelper helper = DbHelper();
              await helper.openDb();
              var result = await helper.searchList("클래식", "songJanre");
              for (var element in result) {
                print(element);
              }
            },
          ),
          const SizedBox(
            height: 20,
          ),
          GestureDetector(
            child: Container(
              child: const Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  "category 관리",
                  style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const MySongJanreCategoryScreen(),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
