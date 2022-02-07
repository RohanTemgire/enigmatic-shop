import 'package:flutter/material.dart';

import '../screens/product_detail_screen.dart';

class ProductItems extends StatelessWidget {
  // const ProductItems({ Key? key }) : super(key: key);

  final String id;
  final String imageUrl;
  final String title;
  final double price;

  const ProductItems(this.id, this.imageUrl, this.title, this.price);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            // Navigator.of(context).push(MaterialPageRoute(
            //     builder: (ctx) => ProductDetailScreen(title))); //this is on the fly, but it can be better for small apps
            Navigator.of(context).pushNamed(ProductDetailScreen.routeName,arguments: id);
          },
          child: Image.network(
            imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        header: GridTileBar(
          backgroundColor: Colors.black54,
          title: Text(
            title,
            textAlign: TextAlign.center,
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          leading: IconButton(
            icon: const Icon(Icons.favorite_border_rounded),
            color: Theme.of(context).accentColor,
            onPressed: () {},
          ),
          title: Text(
            '\$${price}',
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            icon: const Icon(Icons.shopping_cart_outlined),
            color: Theme.of(context).accentColor,
            onPressed: () {},
          ),
        ),
      ),
    );
  }
}
