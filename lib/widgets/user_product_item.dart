import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../screens/edit_product_screen.dart';
import '../provider/products_provider.dart';

class UserProductItem extends StatelessWidget {

  final String id;
  final String title;
  final String imageUrl;

  UserProductItem({this.id,this.title,this.imageUrl});


  @override
  Widget build(BuildContext context) {
    final scaffold=Scaffold.of(context);
    return ListTile(
      title: Text(title) ,
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
        // to set bg as image you have to use NetworkImage
      ),
      trailing: Container(
        //provide width else it gives errors because trailing has fix size
        width: 100,
        child: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.edit),
              color: Theme.of(context).primaryColor,
              onPressed: (){
                Navigator.of(context).pushNamed(EditProductScreen.routeName,arguments: id);
              },
            ),
            IconButton(
              icon: Icon(Icons.delete),
              color: Theme.of(context).errorColor,
              onPressed: ()async{
                try{
                  await Provider.of<Products>(context).deleteProduct(id);
                }
                catch(error){
                  //you cannot use Scaffold.of context in async
                  //so you need to get it from variable
                  scaffold.showSnackBar(
                    SnackBar(
                      content: Text('Deleting item failed.',textAlign: TextAlign.center,),
                    ),
                  );
                }
              },
            ),

          ],
        ),
      ),
    );
  }
}