import 'package:flutter/material.dart';
import 'package:my_karaoke_new_sql/db/db_helper_cate.dart';
import 'package:my_karaoke_new_sql/providers/my_song_category_provider_model%20.dart';
import 'package:my_karaoke_new_sql/screens/my_song_janre_category_screen.dart';
import 'package:provider/provider.dart';

class MySongJanreCategoryEditScreen extends StatelessWidget {
  final int choiceItem;
  const MySongJanreCategoryEditScreen({super.key, required this.choiceItem});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Category Edit '),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.breakfast_dining),
          )
        ],
      ),
      body: Center(
        child: Consumer<MySongCategoryProviderModel>(
          builder: (context, myCnprovider, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                    'data : ${myCnprovider.myItems[choiceItem].songJanreCate}'),
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
                        DbHelperCategory helper = DbHelperCategory();
                        await helper.openDbCategory();
                        await helper.changeSongName(
                            myCnprovider.myItems[choiceItem],
                            '${myCnprovider.myItems[choiceItem].songJanreCate}, hello');
                        var app = Provider.of<MySongCategoryProviderModel>(
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
                    DbHelperCategory helper = DbHelperCategory();
                    await helper.openDbCategory();
                    await helper.deleteList(myCnprovider.myItems[choiceItem]);
                    var app = Provider.of<MySongCategoryProviderModel>(context,
                        listen: false);
                    app.getAllSongs();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MySongJanreCategoryScreen(),
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
