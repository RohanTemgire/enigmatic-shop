import 'package:flutter/material.dart';

import '../models/product.dart';

import '../widgets/products_items.dart';

class ProductsOverviewScreen extends StatelessWidget {
  // const ProductsOverviewScreen({Key? key}) : super(key: key);
  static const routeName = '/product-overview-screen';

  final List<Product> loadedProducts = [
    Product(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Product(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    ),
    Product(
      id: 'p3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageUrl:
          'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    ),
    Product(
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enigmatic Shop'),
      ),
      body: GridView.builder(
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
          return ProductItems(
              loadedProducts[index].id,
              loadedProducts[index].imageUrl,
              loadedProducts[index].title,
              loadedProducts[index].price);
        },
        itemCount: loadedProducts.length,
      ),
    );
  }
}
