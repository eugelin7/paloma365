import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:testtask/=models=/group.dart';
import 'package:testtask/=models=/order.dart';
import 'package:testtask/=models=/product.dart';
import 'package:testtask/data/local_database.dart';
import 'package:testtask/ui/screens/order/screen_logic/order_entry.dart';

class OrderProvider extends ChangeNotifier {
  List<OrderEntry> _orderContent = [];
  UnmodifiableListView<OrderEntry> get orderContent => UnmodifiableListView(_orderContent);

  Group? _selectedGroup;
  Group? get selectedGroup => _selectedGroup;

  void selectGroup(Group? gr) {
    _selectedGroup = gr;
    notifyListeners();
  }

  void addProductToOrder(Product product) {
    final index = _orderContent.indexWhere((el) => el.product.id == product.id);
    if (index >= 0) return;
    _orderContent = [..._orderContent, OrderEntry(product, 1)];
    notifyListeners();
  }

  void removeProductFromOrder(Product product) {
    final index = _orderContent.indexWhere((el) => el.product.id == product.id);
    if (index < 0) return;
    _orderContent = [..._orderContent.sublist(0, index), ..._orderContent.sublist(index + 1)];
    notifyListeners();
  }

  void increaseProductAmount(Product product) {
    final index = _orderContent.indexWhere((el) => el.product.id == product.id);
    if (index < 0) return;
    final curEntry = _orderContent[index];
    _orderContent[index] = OrderEntry(curEntry.product, curEntry.amount + 1);
    notifyListeners();
  }

  void decreaseProductAmount(Product product) {
    final index = _orderContent.indexWhere((el) => el.product.id == product.id);
    if (index < 0) return;
    final curAmount = _orderContent[index].amount;
    if (curAmount == 1) {
      removeProductFromOrder(product);
      return;
    }
    final curEntry = _orderContent[index];
    _orderContent[index] = OrderEntry(curEntry.product, curEntry.amount - 1);
    notifyListeners();
  }

  Future<Order> saveOrder(int placeId) async {
    if (_orderContent.isEmpty) return Future.error('Состав заказа пустой');
    final db = LocalDatabase.instance.database;
    final orderId = await db.insert('Orders', {
      'isActive': 1,
      'placeId': placeId,
    });
    for (var orderEntry in _orderContent) {
      await db.insert('OrderDetails', {
        'orderId': orderId,
        'productId': orderEntry.product.id,
        'amount': orderEntry.amount,
      });
    }
    return Order(id: orderId, isActive: true, placeId: placeId);
  }
}
