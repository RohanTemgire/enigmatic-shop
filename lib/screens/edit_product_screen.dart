import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products.dart';
import '../providers/product.dart';

class EditProductScreen extends StatefulWidget {
  const EditProductScreen({Key? key}) : super(key: key);

  static const routeName = '/edit-product';

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _imageUrlController = TextEditingController();
  //you should dispose controllers after we are done using them
  //they might cause memory leaks

  final _imageUrlFocusNode = FocusNode();
  //you should dispose FocusNodes after we are done using them
  //they might cause memory leaks

  final _form = GlobalKey<FormState>();
  //you use the globalkey when you need to interact with the widget from inside
  //your code. mostly we use it with forms.

  var _editedProducts =
      Product(id: '', title: '', price: 0, imageUrl: '', description: '');

  var _initValues = {
    'title': '',
    'description': '',
    'price': '',
    'imageUrl': '',
  };

  var _isInit = true;

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    //listners should also be disposed
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // because we cant use modal route in the initState, therefor using it in didChangeDependencies
    // didChangeDependencies runs multiple times, we want it to run only one time, therefore using _isInit
    if (_isInit) {
      final productId = ModalRoute.of(context)!.settings.arguments as String;
      if (productId != '') {
        _editedProducts =
            Provider.of<Products>(context, listen: false).findById(productId);
        _initValues = {
          'title': _editedProducts.title,
          'description': _editedProducts.description,
          'price': _editedProducts.price.toString(),
          'imageUrl': _editedProducts.imageUrl,
        };
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();
    super.dispose();
  }

  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      if ((!_imageUrlController.toString().startsWith('http') &&
          !_imageUrlController.toString().startsWith('https'))) {
        return;
      }
      setState(() {});
    }
  }

  void _saveForm() {
    final isValid = _form.currentState?.validate();
    //this will validate all the validators
    if (!isValid!) {
      return;
    }
    _form.currentState!.save();
    // print(_editedProducts.title);
    // print(_editedProducts.description);
    // print(_editedProducts.price);
    // print(_editedProducts.imageUrl);

    if (_editedProducts.id != '') {
      Provider.of<Products>(context, listen: false).updateProduct(_editedProducts.id,_editedProducts);

    } else {
      Provider.of<Products>(context, listen: false).addProduct(_editedProducts);
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Product'),
        actions: [
          IconButton(onPressed: _saveForm, icon: const Icon(Icons.done)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _form,
          // autovalidateMode: AutovalidateMode.onUserInteraction,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextFormField(
                  initialValue: _initValues['title'],
                  decoration: const InputDecoration(
                      labelText: 'Title', errorBorder: InputBorder.none),
                  textInputAction: TextInputAction.next,
                  //this shows the 'next button' on the keyboard so as we press that we go to the next input field
                  onSaved: (val) {
                    _editedProducts = Product(
                        title: val.toString(),
                        price: _editedProducts.price,
                        description: _editedProducts.description,
                        imageUrl: _editedProducts.imageUrl,
                        id: _editedProducts.id,
                        isFavorite: _editedProducts.isFavorite,
                        );
                  },
                  validator: (val) {
                    if (val.toString().isEmpty) {
                      return 'plz enter a String';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  initialValue: _initValues['price'],
                  decoration: const InputDecoration(labelText: 'Price'),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  //switchs the keyboard type to numeric so that we can enter only numbers
                  onSaved: (val) {
                    _editedProducts = Product(
                        title: _editedProducts.title,
                        id: _editedProducts.id,
                        price: double.parse(val.toString()),
                        description: _editedProducts.description,
                        imageUrl: _editedProducts.imageUrl,
                        isFavorite: _editedProducts.isFavorite,);
                  },
                  validator: (val) {
                    if (val.toString().isEmpty) {
                      return 'plz enter a Price';
                    }
                    if (double.tryParse(val.toString()) == null) {
                      //tryparse means it will try to parse the value and if it fails it will return null
                      return 'enter a valid number';
                    }
                    if (double.parse(val.toString()) <= 0) {
                      return 'plz enter value greater than 0';
                    }
                  },
                ),
                TextFormField(
                  initialValue: _initValues['description'],
                  decoration: const InputDecoration(labelText: 'Description'),
                  maxLines: 3,
                  keyboardType: TextInputType.multiline,
                  onSaved: (val) {
                    _editedProducts = Product(
                        title: _editedProducts.title,
                        id: _editedProducts.id,
                        price: _editedProducts.price,
                        description: val.toString(),
                        imageUrl: _editedProducts.imageUrl,
                        isFavorite: _editedProducts.isFavorite,);
                  },
                  validator: (val) {
                    if (val.toString().isEmpty) {
                      return 'plz enter a description';
                    }
                    return null;
                  },
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      margin: const EdgeInsets.only(top: 8, right: 10),
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.blueAccent),
                      ),
                      child: _imageUrlController.text.isEmpty
                          ? const Center(child: Text('Enter a Url'))
                          : Image.network(
                              _imageUrlController.text,
                              fit: BoxFit.cover,
                            ),
                    ),
                    Expanded(
                      child: TextFormField(
                        // initialValue: _initValues['imageUrl'],
                        //you cant have image controller and initvalue at the same time so you can use only one.
                        //we have to set the initial value to the controller to see it reflected
                        decoration:
                            const InputDecoration(labelText: 'Image Url'),
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.url,
                        controller: _imageUrlController,
                        onEditingComplete: () {
                          setState(() {});
                        },
                        focusNode: _imageUrlFocusNode,
                        onFieldSubmitted: (_) => _saveForm(),
                        onSaved: (val) {
                          _editedProducts = Product(
                              title: _editedProducts.title,
                              id: _editedProducts.id,
                              price: _editedProducts.price,
                              description: _editedProducts.description,
                              imageUrl: val.toString(),
                              isFavorite: _editedProducts.isFavorite,);
                        },
                        validator: (val) {
                          if (val.toString().isEmpty) {
                            return 'plz enter a Url';
                          }
                          if (!val.toString().startsWith('http') &&
                              !val.toString().startsWith('https')) {
                            return 'enter a correct Url';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
