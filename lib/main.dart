import 'package:flutter/material.dart';
import 'package:my_karaoke_new_sql/providers/my_changenotifier_provider.dart';
import 'package:my_karaoke_new_sql/providers/my_song_category_provider_model%20.dart';
import 'package:my_karaoke_new_sql/providers/my_song_changenotifier_provider_model.dart';
import 'package:my_karaoke_new_sql/providers/my_song_search_provider_model.dart';
import 'package:my_karaoke_new_sql/screens/my_changenotifierprovider_screen.dart';
import 'package:my_karaoke_new_sql/screens/songs_list_screen.dart';
import 'package:my_karaoke_new_sql/screens/sql_test_gg_screen.dart';
import 'package:my_karaoke_new_sql/screens/test_data_create.dart';
import 'package:provider/provider.dart';
import 'datas/song_item.dart';
import 'db/db_helper.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<MyChangeNotifierProviderModel>(
          create: (_) => MyChangeNotifierProviderModel(),
        ),
        ChangeNotifierProvider<MySongChangeNotifierProviderModel>(
          create: (_) => MySongChangeNotifierProviderModel(),
        ),
        ChangeNotifierProvider<MySongSearchProviderModel>(
          create: (_) => MySongSearchProviderModel(),
        ),
        ChangeNotifierProvider<MySongCategoryProviderModel>(
          create: (_) => MySongCategoryProviderModel(),
        )
      ],
      child: const MaterialApp(
        title: 'My Like Songs',
        debugShowCheckedModeBanner: false,
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Material App Main'),
      ),
      body: Center(
        child: IntrinsicWidth(
          stepWidth: MediaQuery.of(context).size.width * 0.8,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return const TestDataCreate();
                    }),
                  );
                },
                child: const Text(
                  'Test SQL Manage',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return const SongsListScreen();
                    }),
                  );
                },
                child: const Text(
                  'My Song Test data load ',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return const MyChangeNotifierProviderScreen();
                    }),
                  );
                },
                child: const Text(
                  'My Notifier Provider',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return const SongsListScreen();
                    }),
                  );
                },
                child: const Text(
                  'My Song Load',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return const SQLTestGGScreen();
                    }),
                  );
                },
                child: const Text(
                  'SQL Test -- GG Teacher',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future showData() async {
    DbHelper helper = DbHelper();
    List<SongItem>? songList;
    await helper.openDb();
    songList = await helper.getLists();
    print(songList.length);
  }
}
