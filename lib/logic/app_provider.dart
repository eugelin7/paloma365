// ignore_for_file: prefer_final_fields
import 'dart:collection';
import 'package:flutter/foundation.dart';
import 'package:testtask/=models=/group.dart';
import 'package:testtask/=models=/order.dart';
import 'package:testtask/=models=/order_details.dart';
import 'package:testtask/=models=/place.dart';
import 'package:testtask/=models=/product.dart';
import 'package:testtask/data/local_database.dart';
//
part '_init_.dart';
part '_orders_.dart';
//

class AppProvider extends ChangeNotifier {
  void notify() => notifyListeners();

  bool _isInitialized = false;
  bool get isInitialized => _isInitialized;

  List<Group> _groups = [];
  UnmodifiableListView<Group> get groups => UnmodifiableListView(_groups);

  List<Product> _products = [];
  UnmodifiableListView<Product> get products => UnmodifiableListView(_products);

  List<Place> _places = [];
  UnmodifiableListView<Place> get places => UnmodifiableListView(_places);

  List<Order> _orders = [];
  UnmodifiableListView<Order> get orders => UnmodifiableListView(_orders);
}
