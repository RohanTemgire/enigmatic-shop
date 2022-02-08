import 'package:flutter/material.dart';

import './screens/product_detail_screen.dart';
import './screens/products_overview_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
