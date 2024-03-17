import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testtask/=models=/product.dart';
import 'package:testtask/logic/app_provider.dart';
import 'package:testtask/ui/screens/order/screen_logic/order_provider.dart';

class ProductsList extends StatelessWidget {
  const ProductsList({super.key});

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context, listen: false);
    final List<Product> products = context.select<OrderProvider, List<Product>>((pr) {
      final selGroup = pr.selectedGroup;
      List<Product> products = (selGroup == null)
          ? appProvider.products
          : appProvider.products.where((el) => el.groupId == selGroup.id).toList();
      final productsInOrder = pr.orderContent.map((e) => e.product.id).toSet();
      return products.where((el) => !productsInOrder.contains(el.id)).toList();
    });

    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      itemCount: products.length,
      itemBuilder: (_, i) => GestureDetector(
        onTap: () {
          context.read<OrderProvider>().addProductToOrder(products[i]);
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Text(products[i].name, style: const TextStyle(fontSize: 17)),
        ),
      ),
      separatorBuilder: (context, index) => const Divider(height: 1, thickness: 1),
    );
  }
}
