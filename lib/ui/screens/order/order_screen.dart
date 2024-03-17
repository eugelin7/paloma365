import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testtask/=models=/group.dart';
import 'package:testtask/=models=/place.dart';
import 'package:testtask/logic/app_provider.dart';
import 'package:testtask/ui/screens/order/screen_logic/order_provider.dart';
import 'package:testtask/ui/screens/order/widgets/group_chip.dart';
import 'package:testtask/ui/screens/order/widgets/order_entries_list.dart';
import 'package:testtask/ui/screens/order/widgets/products_list.dart';

class OrderScreen extends StatelessWidget {
  static const id = 'order_screen';

  final Place place;

  const OrderScreen({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    final List<Group> groups = context.select<AppProvider, List<Group>>((pr) => pr.groups);

    return ChangeNotifierProvider(
      create: (context) => OrderProvider(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Оформление заказа'),
          centerTitle: true,
        ),
        body: Column(
          children: [
            const SizedBox(width: double.infinity, height: 16),
            Text(
              place.name,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 18),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: groups
                    .map((gr) => Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: GroupChip(group: gr),
                        ))
                    .toList(),
              ),
            ),
            const SizedBox(height: 12),
            const Expanded(
              child: ProductsList(),
            ),
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                color: Colors.blue.shade100,
                border: Border(top: BorderSide(color: Colors.blue.shade700, width: 2)),
              ),
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: const Center(
                child: Text(
                  'Состав заказа',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.3,
              child: const OrderEntriesList(),
            ),
            Container(
              height: 80,
              color: Colors.blue.shade100,
              child: Row(
                children: [
                  const Spacer(),
                  Builder(builder: (context) {
                    return ElevatedButton(
                      onPressed: () async {
                        try {
                          final appProvider = Provider.of<AppProvider>(context, listen: false);
                          final navigator = Navigator.of(context);
                          final order = await context.read<OrderProvider>().saveOrder(place.id);
                          appProvider.addNewOrder(order);
                          navigator.pop();
                        } catch (e) {
                          debugPrint(e.toString());
                        }
                      },
                      child: const Text('Сохранить', style: TextStyle(fontSize: 16)),
                    );
                  }),
                  const SizedBox(width: 10),
                  OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text(' Отмена ', style: TextStyle(fontSize: 16)),
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
