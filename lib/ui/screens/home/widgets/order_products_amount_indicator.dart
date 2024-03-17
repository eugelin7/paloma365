import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testtask/logic/app_provider.dart';

class OrderProductsAmountIndicator extends StatefulWidget {
  final int activeOrderId;

  const OrderProductsAmountIndicator({super.key, required this.activeOrderId});

  @override
  State<OrderProductsAmountIndicator> createState() => _OrderProductsAmountIndicatorState();
}

class _OrderProductsAmountIndicatorState extends State<OrderProductsAmountIndicator> {
  int _amount = 0;

  @override
  void initState() {
    super.initState();
    final appProvider = Provider.of<AppProvider>(context, listen: false);
    appProvider.getOrderDetails(widget.activeOrderId).then((value) {
      int amount = 0;
      for (var el in value.entries) {
        amount += el.value;
      }
      setState(() {
        _amount = amount;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 14,
      backgroundColor: Colors.red,
      child: (_amount == 0)
          ? null
          : Text(
              _amount.toString(),
              style: const TextStyle(
                fontSize: 13,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
    );
  }
}
