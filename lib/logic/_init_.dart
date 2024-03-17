part of 'app_provider.dart';

extension Init on AppProvider {
  // Инициализация
  void init() async {
    if (_isInitialized) return;

    final db = LocalDatabase.instance.database;

    final groups = await db.query('Groups');
    for (var group in groups) {
      _groups.add(Group(id: group['id'] as int, name: group['name'] as String));
    }

    final products = await db.query('Products');
    for (var product in products) {
      _products.add(Product(
        id: product['id'] as int,
        name: product['name'] as String,
        groupId: product['groupId'] as int,
      ));
    }

    final places = await db.query('Places');
    for (var place in places) {
      _places.add(Place(id: place['id'] as int, name: place['name'] as String));
    }

    final orders = await db.query('Orders');
    for (var order in orders) {
      _orders.add(Order(
        id: order['id'] as int,
        isActive: order['isActive'] as int != 0,
        placeId: order['placeId'] as int,
      ));
    }

    _isInitialized = true;
    notify();
  }
}
