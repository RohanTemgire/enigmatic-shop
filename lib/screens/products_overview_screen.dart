import 'package:flutter/material.dart';

import '../widgets/products_grid.dart';

enum filterOpts {
  Favroite,
  All,
}

class ProductsOverviewScreen extends StatefulWidget {
  // const ProductsOverviewScreen({Key? key}) : super(key: key);
  static const routeName = '/product-overview-screen';

  @override
  State<ProductsOverviewScreen> createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var _showOnlyFavorites = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enigmatic Shop'),
        actions: [
          PopupMenuButton(
            icon: Icon(Icons.more_vert),
            onSelected: (filterOpts selectedValue) {
              setState(() {
                if (selectedValue == filterOpts.Favroite) {
                  _showOnlyFavorites = true;
                } else {
                  _showOnlyFavorites = false;
                }
              });
            },
            itemBuilder: (_) => [
              PopupMenuItem(
                  child: Text('Show Fav'), value: filterOpts.Favroite),
              PopupMenuItem(child: Text('Show All'), value: filterOpts.All),
            ],
          )
        ],
      ),
      body: productsGrid(_showOnlyFavorites),
    );
  }
}
