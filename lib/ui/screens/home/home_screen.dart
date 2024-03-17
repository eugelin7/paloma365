import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testtask/=models=/place.dart';
import 'package:testtask/logic/app_provider.dart';
import 'package:testtask/ui/screens/home/widgets/place_widget.dart';
import 'package:testtask/ui/screens/orders_list/orders_list_screen.dart';

class HomeScreen extends StatelessWidget {
  static const id = 'home_screen';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isInitialized = context.select<AppProvider, bool>((pr) => pr.isInitialized);
    final List<Place> places = context.select<AppProvider, List<Place>>((pr) => pr.places);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Главный экран'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(OrdersListScreen.id);
            },
            icon: const Icon(Icons.table_rows),
          )
        ],
      ),
      body: isInitialized
          ? GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.0,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
              ),
              padding: const EdgeInsets.all(25),
              itemCount: places.length,
              itemBuilder: (_, i) => PlaceWidget(place: places[i]),
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
