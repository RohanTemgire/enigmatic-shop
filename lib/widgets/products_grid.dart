import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/product.dart';
import '../providers/products.dart';
import '../widgets/products_items.dart';

class productsGrid extends StatelessWidget {
  final bool showFav;
  productsGrid(this.showFav);
  
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final products = showFav ? productsData.favoriteItems : productsData.item;
    return GridView.builder(
      //builder method is usefull bc it does not load all the items in the grid, instead it loads items only which are on the screen
      // and few more which are below the screen, so that when we scroll the items are there.
      padding: const EdgeInsets.all(10.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        //grid delegate defines how the grid is structured, how many columns it should have
        crossAxisCount: 1,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (ctx, index) {
        //here it takes the context and a index number is provided where we can build each widget for the following
        //item builder defines how every item is build, how every grid cell should be.
        return ChangeNotifierProvider<Product>.value(
          value: products[index],
          child: ProductItems(
              // products[index].id,
              // products[index].imageUrl,
              // products[index].title,
              // products[index].price,
              ),
        );
      },
      itemCount: products.length,
    );
  }
}
