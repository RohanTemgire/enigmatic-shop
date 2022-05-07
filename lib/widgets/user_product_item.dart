import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products.dart';
import '../screens/edit_product_screen.dart';

class UserProductItem extends StatelessWidget {
  // const UserProductItem({ Key? key }) : super(key: key);

  final String title;
  final String id;
  final String imgUrl;
  final bool shouldChange = true;


  UserProductItem(this.id, this.title, this.imgUrl);

  @override
  Widget build(BuildContext context) {
    final scaffold =  Scaffold.of(context);
    return Card(
      elevation: 5,
      child: ListTile(
        title: Text(title),
        leading: CircleAvatar(
          backgroundImage: NetworkImage(imgUrl),
        ),
        trailing: Container(
          width: 100,
          child: Row(
            children: [
              IconButton(
                onPressed: () {
                  // if (id == null) {
                  //   final newId = DateTime.now().toString();
                  //   Navigator.of(context).pushNamed(EditProductScreen.routeName, arguments: newId);
                  // }else{
                    Navigator.of(context).pushNamed(EditProductScreen.routeName, arguments: id);

                  // }
                },
                icon: const Icon(Icons.edit),
                color: Theme.of(context).primaryColor,
              ),
              IconButton(
                onPressed: () async {
                  try{
                  await Provider.of<Products>(context, listen: false)
                      .deleteProduct(id);

                  }catch(err){
                    //since this is a future and it cannot build a context yet so have to use a variable to store the context
                    scaffold.showSnackBar(const SnackBar(content:  Text('Deleting failed! :(',textAlign: TextAlign.center,)));
                  }
                },
                icon: const Icon(Icons.delete),
                color: Theme.of(context).errorColor,
              )
            ],
          ),
        ),
      ),
    );
  }
}
