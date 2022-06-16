import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/app_drawer.dart';
import '../screens/cart_screen.dart';
import '../providers/cart.dart';
import '../widgets/badge.dart';
import '../widgets/products_grid.dart';
import '../providers/products.dart';

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
  var _isinit = true;
  var _isLoading = false;
  // var _productsLoadedCompletely =false;

  @override
  void initState() {
    // Provider.of<Products>(context).fetchProducts();//this wont work cause of context doesnt work in initstate

    // Future.delayed(Duration.zero)
    //     .then((_) => Provider.of<Products>(context).fetchProducts());
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isinit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Products>(context).getProducts().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isinit = false;
    super.didChangeDependencies();
  }
  // Future<void> _allProductsLoaded(showOnlyFavorites) async{
  //   var products = await Provider.of<Products>(context).fetchProducts();
  //   productsGrid(showOnlyFavorites);
  // }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enigmatic Shop'),
        actions: [
          PopupMenuButton(
            icon: const Icon(Icons.more_vert),
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
              const PopupMenuItem(
                  child: Text('Show Fav'), value: filterOpts.Favroite),
              const PopupMenuItem(
                  child: Text('Show All'), value: filterOpts.All),
            ],
          ),
          Consumer<Cart>(
            builder: (_, cart, ch) => Badge(
              child: ch as Widget,
              value: cart.itemCount.toString(),
              color: Theme.of(context).accentColor,
            ),
            child: IconButton(
              icon: const Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
            ),
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          :  productsGrid(_showOnlyFavorites),
    );
  }
}
