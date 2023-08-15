import 'package:flutter/material.dart';
import 'package:my_karaoke_new_sql/providers/my_changenotifier_provider.dart';
import 'package:my_karaoke_new_sql/screens/my_changenotifierprovider_screen.dart';
import 'package:provider/provider.dart';

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
      ],
      child: const MaterialApp(
        title: 'My Like Songs',
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
                      return const MyChangeNotifierProviderScreen();
                    }),
                  );
                },
                child: const Text(
                  'My Notifier Provider',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
