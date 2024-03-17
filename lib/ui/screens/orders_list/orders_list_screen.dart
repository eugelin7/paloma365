import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testtask/=models=/order.dart';
import 'package:testtask/=models=/order_details.dart';
import 'package:testtask/logic/app_provider.dart';
import 'package:testtask/ui/common_widgets/order_product_entry.dart';

class OrdersListScreen extends StatefulWidget {
  static const id = 'orders_list_screen';

  const OrdersListScreen({super.key});

  @override
  State<OrdersListScreen> createState() => _OrdersListScreenState();
}

class _OrdersListScreenState extends State<OrdersListScreen> {
  late final AppProvider _appProvider;
  late final List<Order> _reversedOrders;
  List<OrderDetails> _orderDetailsList = [];
  bool _isLoaded = false;
  bool _isShowActiveOrders = true;

  @override
  void initState() {
    super.initState();
    _appProvider = Provider.of<AppProvider>(context, listen: false);
    _reversedOrders = _appProvider.orders.reversed.toList();
    _appProvider.getOrderDetailsList().then((orderDetailsList) {
      _orderDetailsList = orderDetailsList;
      _isLoaded = true;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final orders = _reversedOrders.where((el) => el.isActive == _isShowActiveOrders).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Все заказы'),
        centerTitle: true,
      ),
      body: _isLoaded
          ? Column(
              children: [
                const SizedBox(width: double.infinity, height: 20),
                Row(
                  children: [
                    const SizedBox(width: 20),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() {
                          _isShowActiveOrders = true;
                        }),
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: _isShowActiveOrders
                                ? Colors.deepPurple.shade300
                                : Colors.deepPurple.shade100,
                            borderRadius: const BorderRadius.horizontal(left: Radius.circular(15)),
                          ),
                          child: Center(
                            child: Text(
                              'Активные',
                              style: TextStyle(
                                fontSize: _isShowActiveOrders ? 17 : 15,
                                color: _isShowActiveOrders ? Colors.white : Colors.grey.shade700,
                                fontWeight:
                                    _isShowActiveOrders ? FontWeight.bold : FontWeight.normal,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() {
                          _isShowActiveOrders = false;
                        }),
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: _isShowActiveOrders
                                ? Colors.deepPurple.shade100
                                : Colors.deepPurple.shade300,
                            borderRadius: const BorderRadius.horizontal(right: Radius.circular(15)),
                          ),
                          child: Center(
                            child: Text(
                              'Завершённые',
                              style: TextStyle(
                                fontSize: _isShowActiveOrders ? 15 : 17,
                                color: _isShowActiveOrders ? Colors.grey.shade700 : Colors.white,
                                fontWeight:
                                    _isShowActiveOrders ? FontWeight.normal : FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                  ],
                ),
                const SizedBox(height: 22),
                Expanded(
                  child: ListView.builder(
                    key: ValueKey(_isShowActiveOrders),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: orders.length,
                    itemBuilder: (_, i) {
                      final orderId = orders[i].id;
                      final placeId = orders[i].placeId;
                      final place = _appProvider.places.firstWhere((el) => el.id == placeId);
                      final orderDetails =
                          _orderDetailsList.where((el) => el.orderId == orderId).toList();
                      return Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade500),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        margin: const EdgeInsets.only(bottom: 18),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(height: 8),
                            Text(
                              place.name,
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey.shade800,
                              ),
                            ),
                            const SizedBox(height: 2),
                            ...orderDetails.map((item) {
                              final productId = item.productId;
                              final product =
                                  _appProvider.products.firstWhere((el) => el.id == productId);
                              return OrderProductEntry(
                                product: product,
                                amount: item.amount,
                                height: 20,
                              );
                            }).toList(),
                            const SizedBox(height: 11),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
