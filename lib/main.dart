import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/product_detail_screen.dart';
import './screens/products_overview_screen.dart';
import './providers/products.dart';
import './providers/cart.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Products>(create: (ctx) => Products()),
        ChangeNotifierProvider<Cart>(create: (ctx) => Cart()),
      ],
      child: MaterialApp(
        title: 'Enigmatic Shop',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          accentColor: Colors.orange,
          fontFamily: 'Lato',
        ),
        // home: MyHomePage(),
        initialRoute: '/',
        routes: {
          '/': (ctx) => ProductsOverviewScreen(),
          ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
        },
      ),
    );
  }
}

// class MyHomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Enigmatic Shop'),
//       ),
//       body: const Center(
//         child: Text('Enigmatic Shop'),
//       ),
//     );
//   }
// }
