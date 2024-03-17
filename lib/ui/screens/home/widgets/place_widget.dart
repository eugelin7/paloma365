import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testtask/=models=/place.dart';
import 'package:testtask/logic/app_provider.dart';
import 'package:testtask/ui/screens/home/widgets/order_products_amount_indicator.dart';
import 'package:testtask/ui/screens/order/order_screen.dart';
import 'package:testtask/ui/screens/order_details/order_details_screen.dart';

class PlaceWidget extends StatelessWidget {
  final Place place;

  const PlaceWidget({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    final int? activeOrderId = context.select<AppProvider, int?>((pr) {
      for (var order in pr.orders) {
        if ((order.placeId == place.id) && order.isActive) return order.id;
      }
      return null;
    });

    return GestureDetector(
      onTap: () {
        if (activeOrderId == null) {
          Navigator.of(context).pushNamed(OrderScreen.id, arguments: place);
        } else {
          Navigator.of(context).pushNamed(OrderDetailsScreen.id, arguments: [place, activeOrderId]);
        }
      },
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(500),
            ),
            child: Center(
              child: Text(
                place.name,
                style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          if (activeOrderId != null)
            Positioned(
              right: 13,
              top: 13,
              child: OrderProductsAmountIndicator(activeOrderId: activeOrderId),
            )
        ],
      ),
    );
  }
}
