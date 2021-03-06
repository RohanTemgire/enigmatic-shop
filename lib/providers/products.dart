import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/http_exception.dart';
import './product.dart';

class Products with ChangeNotifier {
  List<Product> _items = [
    // Product(
    //   id: 'p1',
    //   title: 'Red Shirt',
    //   description: 'A red shirt - it is pretty red!',
    //   price: 29.99,
    //   imageUrl:
    //       'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    // ),
    // Product(
    //   id: 'p2',
    //   title: 'Trousers',
    //   description: 'A nice pair of trousers.',
    //   price: 59.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    // ),
    // Product(
    //   id: 'p3',
    //   title: 'Yellow Scarf',
    //   description: 'Warm and cozy - exactly what you need for the winter.',
    //   price: 19.99,
    //   imageUrl:
    //       'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    // ),
    // Product(
    //   id: 'p4',
    //   title: 'A Pan',
    //   description: 'Prepare any meal you want.',
    //   price: 49.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    // ),
  ];

  List<Product> get item {
    return [..._items];
  }

  List<Product> get favoriteItems {
    return _items.where((element) => element.isFavorite).toList();
  }

  Product findById(String id) {
    return _items.firstWhere((element) => element.id == id);
  }

  Future<void> addProduct(Product product) async {
    final url = Uri.parse(
        'https://enigmaticshop-81a56-default-rtdb.firebaseio.com' +
            '/products.json');
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'title': product.title,
          'description': product.description,
          'imageurl': product.imageUrl,
          'price': product.price,
          'isFavorite': product.isFavorite,
        }),
      );
      final newProduct = Product(
        id: json.decode(response.body)['name'],
        title: product.title,
        description: product.description,
        imageUrl: product.imageUrl,
        price: product.price,
      );

      _items.add(newProduct);
      // _items.insert(0,newProduct); // to add at the start of the list
      notifyListeners();
    } catch (err) {
      print(err);
      throw err;
    }

    // }).catchError((err) {
    //   print(err);
    //   throw err;
    // });
  }

  // static List<Product> parseProducts(String responsebody){
  //   var list = json.decode(responsebody) as List<dynamic>;
  //   List<Product> products = list.map((e) => null)
  // }

  Future<void> getProducts() async {
    final url = Uri.parse(
        'https://enigmaticshop-81a56-default-rtdb.firebaseio.com' +
            '/products.json');
    try {
      final data = await http.get(url);
      var jsonData = json.decode(data.body) as Map<String, dynamic>;
      final List<Product> products = [];
      jsonData.forEach((prodId, prodData) {
        products.add(Product(
            id: prodId,
            title: prodData['title'],
            description: prodData['description'],
            imageUrl: prodData['imageurl'],
            isFavorite: prodData['isFavorite'],
            price: prodData['price']));
      });

      // print(products.length);
      _items = products.toList();
      notifyListeners();
    } catch (err) {
      print(err);
    }
  }

  Future<void> updateProduct(String id, Product newProduct) async {
    final prodIndex = _items.indexWhere((element) => element.id == id);
    if (prodIndex >= 0) {
      final url = Uri.parse(
          'https://enigmaticshop-691ff-default-rtdb.firebaseio.com' +
              '/products.json/$id');
      try {
        await http.patch(url,
            body: json.encode({
              'title': newProduct.title,
              'description': newProduct.description,
              'imageurl': newProduct.imageUrl,
              'price': newProduct.price.toDouble(),
            }));
        _items[prodIndex] = newProduct;
        notifyListeners();
      } catch (err) {
        print(err);
      }
    } else {
      print('item not updated!');
    }
  }

  Future<void> deleteProduct(String id) async {
    final url = Uri.parse(
        'https://enigmaticshop-691ff-default-rtdb.firebaseio.com' +
            '/products.json/$id');
    var existingProductIndex = _items.indexWhere((element) => element.id == id);
    var existingProduct = _items[existingProductIndex];

    // _items.removeWhere((element) => element.id == id);
    _items.removeAt(existingProductIndex);
    notifyListeners();
    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      _items.insert(existingProductIndex, existingProduct);
      notifyListeners();
      throw HttpException('Could not delete the product.');
    }
  }
}
