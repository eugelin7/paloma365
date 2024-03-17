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
