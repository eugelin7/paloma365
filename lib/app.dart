import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testtask/=models=/place.dart';
import 'package:testtask/logic/app_provider.dart';
import 'package:testtask/ui/screens/home/home_screen.dart';
import 'package:testtask/ui/screens/order/order_screen.dart';
import 'package:testtask/ui/screens/order_details/order_details_screen.dart';
import 'package:testtask/ui/screens/orders_list/orders_list_screen.dart';

class Paloma365App extends StatelessWidget {
  const Paloma365App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AppProvider()..init(),
      child: MaterialApp(
        routes: {
          HomeScreen.id: (context) => const HomeScreen(),
          OrderScreen.id: (context) => OrderScreen(
                place: (ModalRoute.of(context)!.settings.arguments!) as Place,
              ),
          OrderDetailsScreen.id: (context) {
            final args = ModalRoute.of(context)!.settings.arguments! as List<dynamic>;
            return OrderDetailsScreen(place: args[0] as Place, orderId: args[1] as int);
          },
          OrdersListScreen.id: (context) => const OrdersListScreen(),
        },
        initialRoute: HomeScreen.id,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
