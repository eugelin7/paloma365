import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testtask/=models=/place.dart';
import 'package:testtask/logic/app_provider.dart';
import 'package:testtask/ui/common_widgets/order_product_entry.dart';

class OrderDetailsScreen extends StatefulWidget {
  static const id = 'order_details_screen';

  final Place place;
  final int orderId;

  const OrderDetailsScreen({
    super.key,
    required this.place,
    required this.orderId,
  });

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  late final AppProvider _appProvider;
  List<MapEntry<int, int>> _orderDetails = [];

  @override
  void initState() {
    super.initState();
    _appProvider = Provider.of<AppProvider>(context, listen: false);
    _appProvider.getOrderDetails(widget.orderId).then((orderDetails) {
      _orderDetails = orderDetails.entries.toList();
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Заказ'),
        centerTitle: true,
      ),
      body: _orderDetails.isNotEmpty
          ? Column(
              children: [
                const SizedBox(width: double.infinity, height: 16),
                Text(
                  widget.place.name,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 18),
                Expanded(
                  child: ListView.builder(
                    itemCount: _orderDetails.length,
                    itemBuilder: (_, i) {
                      final productId = _orderDetails[i].key;
                      final product = _appProvider.products.firstWhere((el) => el.id == productId);
                      return OrderProductEntry(
                        product: product,
                        amount: _orderDetails[i].value,
                        height: 40,
                        topBorder: (i == 0),
                        bottomBorder: true,
                      );
                    },
                  ),
                ),
                Container(
                  height: 80,
                  width: double.infinity,
                  color: Colors.blue.shade100,
                  child: Center(
                    child: ElevatedButton(
                      onPressed: () async {
                        try {
                          final navigator = Navigator.of(context);
                          await _appProvider.setOrderAsDone(widget.orderId);
                          navigator.pop();
                        } catch (e) {
                          debugPrint(e.toString());
                        }
                      },
                      child: const Text('Заказ выполнен', style: TextStyle(fontSize: 16)),
                    ),
                  ),
                ),
              ],
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
