import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testtask/ui/screens/order/screen_logic/order_entry.dart';
import 'package:testtask/ui/screens/order/screen_logic/order_provider.dart';

class OrderEntryWidget extends StatelessWidget {
  final OrderEntry orderEntry;

  const OrderEntryWidget({super.key, required this.orderEntry});

  @override
  Widget build(BuildContext context) {
    final int amount = context.select<OrderProvider, int>((pr) {
      final index = pr.orderContent.indexWhere((el) => el.product.id == orderEntry.product.id);
      if (index < 0) return 0;
      return pr.orderContent[index].amount;
    });

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          const SizedBox(width: 18),
          Expanded(
            child: Text(
              orderEntry.product.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 17),
            ),
          ),
          GestureDetector(
            onTap: () {
              context.read<OrderProvider>().decreaseProductAmount(orderEntry.product);
            },
            child: CircleAvatar(
              radius: 14,
              backgroundColor: Colors.red.shade100,
              child: Icon(Icons.remove_circle, size: 17, color: Colors.red.shade300),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 9),
            child: Text(amount.toString(), style: const TextStyle(fontSize: 17)),
          ),
          GestureDetector(
            onTap: () {
              context.read<OrderProvider>().increaseProductAmount(orderEntry.product);
            },
            child: CircleAvatar(
              radius: 14,
              backgroundColor: Colors.green.shade100,
              child: Icon(Icons.add_circle, size: 17, color: Colors.green.shade300),
            ),
          ),
          const SizedBox(width: 10),
        ],
      ),
    );
  }
}
