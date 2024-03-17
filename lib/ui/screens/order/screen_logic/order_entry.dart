import 'package:testtask/=models=/product.dart';

class OrderEntry {
  final Product product;
  final int amount;

  const OrderEntry(this.product, this.amount);
}
