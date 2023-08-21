import 'package:flutter/material.dart';
import '../datas/song_item.dart';
import '../db/db_helper.dart';

class MySongAppendScreen extends StatefulWidget {
  const MySongAppendScreen({super.key});

  @override
  State<MySongAppendScreen> createState() => _MySongAppendScreenState();
}

class _MySongAppendScreenState extends State<MySongAppendScreen> {
  final _formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  String? _songName, _songGYNumber, _songTJNumber, _songUtubeAddress, _songETC;
  final String _songFavorite = "false";
  String _selJanre = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('append screen'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          autovalidateMode: autovalidateMode,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  30.0,
                  20.0,
                  30.0,
                  10.0,
                ),
                child: TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    filled: true,
                    labelText: '곡명',
                  ),
                  validator: (val) =>
                      val!.trim().isEmpty ? '곡명은 필수 입니다.' : null,
                  onSaved: (val) => _songName = val,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30.0,
                  vertical: 5.0,
                ),
                child: TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    filled: true,
                    labelText: '금영노래방 번호',
                  ),
                  // validator: (val) =>
                  //     val!.trim().isEmpty ? '금영노래방 번호는 필수입니다' : null,
                  onSaved: (val) => _songGYNumber = val ?? "",
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30.0,
                  vertical: 5.0,
                ),
                child: TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    filled: true,
                    labelText: '태진노래방 번호',
                  ),
                  onSaved: (val) => _songTJNumber = val ?? "",
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30.0,
                  vertical: 5.0,
                ),
                child: Row(
                  children: [
                    const Text(
                      "노래 쟝르를 선택하세요!",
                      style: TextStyle(
                          color: Colors.red, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    DropdownButton(
                      items: ["팝", "발라드", "클래식", "트로트", "댄스"]
                          .map((e) => DropdownMenuItem(
                                value: e,
                                child: Text("장르 : $e"),
                              ))
                          .toList(),
                      onChanged: (String? value) {
                        setState(() {
                          _selJanre = value ?? "";
                        });
                      },
                      icon: const Icon(Icons.pin_drop),
                    ),
                    Text(_selJanre)
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30.0,
                  vertical: 5.0,
                ),
                child: TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    filled: true,
                    labelText: '관련 유튜브 주소',
                  ),
                  onSaved: (val) => _songUtubeAddress = val ?? "",
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30.0,
                  vertical: 5.0,
                ),
                child: TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    filled: true,
                    labelText: '특기사항',
                  ),
                  onSaved: (val) => _songETC = val ?? "",
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(
              //     horizontal: 30.0,
              //     vertical: 5.0,
              //   ),
              //   child: TextFormField(
              //     decoration: const InputDecoration(
              //       border: OutlineInputBorder(),
              //       filled: true,
              //       labelText: '날짜',
              //     ),
              //     // readOnly: true,
              //     enabled: false,
              //     onSaved: (val) => _createTime =
              //         "${DateTime.now().year}.${DateTime.now().month}.${DateTime.now().day}",
              //   ),
              // ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () => submit("add"),
                child: const Text(
                  'Add Song',
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void submit(String mode) async {
    setState(() {
      autovalidateMode = AutovalidateMode.always;
    });

    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();
    try {
      DbHelper helper = DbHelper();
      await helper.openDb();
      final newEventDetail = SongItem(
          null,
          _songName!,
          _songGYNumber!,
          _songTJNumber!,
          _selJanre,
          _songUtubeAddress!,
          _songETC!,
          "${DateTime.now().year}.${DateTime.now().month}.${DateTime.now().day}",
          _songFavorite);
      await helper.insertList(newEventDetail);
      Navigator.pop(context, 'success');
    } catch (e) {
      print(e);
    }
  }
}
