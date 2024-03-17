import 'package:flutter/material.dart';
import 'package:testtask/app.dart';
import 'package:testtask/data/local_database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await LocalDatabase.instance.init();
  } catch (e) {
    throw Exception(e);
  }

  runApp(const Paloma365App());
}

/*
class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: () async {
                  await LocalDatabase.instance.init();
                  print('init Ok!');
                },
                child: Text('init db'),
              ),
              ElevatedButton(
                onPressed: () async {
                  final db = LocalDatabase.instance.database;
                  final groups = await db.query('Groups');
                  for (var group in groups) {
                    print(group);
                    print('-----------');
                  }
                  final items = await db.query('Products');
                  for (var item in items) {
                    print(item);
                    print('-----------');
                  }
                  final orderdts = await db.query('OrderDetails');
                },
                child: Text('read data'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
*/