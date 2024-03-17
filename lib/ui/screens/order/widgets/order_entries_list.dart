import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testtask/ui/screens/order/screen_logic/order_entry.dart';
import 'package:testtask/ui/screens/order/screen_logic/order_provider.dart';
import 'package:testtask/ui/screens/order/widgets/order_entry_widget.dart';

class OrderEntriesList extends StatelessWidget {
  const OrderEntriesList({super.key});

  @override
  Widget build(BuildContext context) {
    final List<OrderEntry> orderEntries =
        context.select<OrderProvider, List<OrderEntry>>((pr) => pr.orderContent);

    return ListView.separated(
      itemCount: orderEntries.length,
      itemBuilder: (_, i) => OrderEntryWidget(orderEntry: orderEntries[i]),
      separatorBuilder: (context, index) => const Divider(height: 1, thickness: 1),
    );
  }
}
