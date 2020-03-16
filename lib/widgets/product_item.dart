import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/product_detail_screen.dart';
import '../provider/product.dart';

class ProductItem extends StatelessWidget {
  
  /*
  final String id;
  final String title;
  final String imageUrl;

  ProductItem({this.id, this.title, this.imageUrl});
  */

  @override
  Widget build(BuildContext context) {

    final Product product=Provider.of<Product>(context,listen: false);
    //if you provide false here then UI does not change
    print('product build');
    //print statement not executed if we press like 
    //means only leading part rebuild
    //you have set the listen to the false thats why this is happening

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      //ClipRRect is used to provide circular border
      child: GridTile(
        child: GestureDetector(
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
          onTap: (){
            Navigator.of(context).pushNamed(ProductDetailScreen.routeName,arguments: product.id);
          },
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          leading: Consumer<Product>(
            builder: (ctx,product,child)=>IconButton(
              //in this contsructor child is something which will never change 
              color: Theme.of(context).accentColor,
              icon: Icon(product.isFavorite?Icons.favorite:Icons.favorite_border),
              onPressed: () {
                product.toggleFavoriteStatus();
                //here we donot require the setState as we are manage state via provider
              },
            ),
          ),
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
              color: Theme.of(context).accentColor,
              icon: Icon(Icons.shopping_cart),
              onPressed: () {}),
        ),
      ),
    );
  }
}
