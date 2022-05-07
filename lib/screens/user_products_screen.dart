import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';

import '../screens/edit_product_screen.dart';

import '../widgets/user_product_item.dart';
import '../widgets/app_drawer.dart';

class UserProductsScreen extends StatelessWidget {
  // const UserProductsScreen({ Key? key }) : super(key: key);
  static const routeName = '/user-products';

  Future<void> _refreshProds (BuildContext context) async{
    await Provider.of<Products>(context,listen: false).getProducts();
  }

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Products'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(EditProductScreen.routeName);
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: RefreshIndicator(
        onRefresh: () => _refreshProds(context),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView.builder(
              itemCount: productsData.item.length,
              itemBuilder: (_, i) {
                return UserProductItem(
                  productsData.item[i].id,
                  productsData.item[i].title,
                  productsData.item[i].imageUrl,
                );
              }),
        ),
      ),
    );
  }
}
