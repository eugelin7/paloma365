part of 'app_provider.dart';

extension Orders on AppProvider {
  void addNewOrder(Order newOrder) {
    _orders = [..._orders, newOrder];
    notify();
  }

  // Возвращает мапу, где ключ - productId, значение - количество этого продукта в заказе
  Future<Map<int, int>> getOrderDetails(int orderId) async {
    final db = LocalDatabase.instance.database;
    final raws = await db.rawQuery('SELECT * FROM OrderDetails WHERE orderId=?', [orderId]);
    final result = <int, int>{};
    for (var raw in raws) {
      result[raw['productId'] as int] = raw['amount'] as int;
    }
    return result;
  }

  // Помечает заказ, как выполненный
  Future<void> setOrderAsDone(int orderId) async {
    final db = LocalDatabase.instance.database;
    try {
      await db.rawUpdate('UPDATE Orders SET isActive = ? WHERE id = ?', [0, orderId]);
      final index = _orders.indexWhere((el) => el.id == orderId);
      if (index >= 0) {
        _orders[index] = Order(id: orderId, isActive: false, placeId: _orders[index].placeId);
        notify();
      }
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  // Возвращает список OrderDetails
  Future<List<OrderDetails>> getOrderDetailsList() async {
    List<OrderDetails> result = [];
    final db = LocalDatabase.instance.database;
    final raws = await db.rawQuery('SELECT * FROM OrderDetails');
    for (var raw in raws) {
      result.add(OrderDetails(
        orderId: raw['orderId'] as int,
        productId: raw['productId'] as int,
        amount: raw['amount'] as int,
      ));
    }
    return result;
  }
}
