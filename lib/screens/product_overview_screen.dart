import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/provider/product.dart';
import 'package:shop/provider/products_provider.dart';

import '../widgets/products_grid.dart';

enum FilterOptions{
  Favorites,
  All,
}

class ProductsOverviewScreen extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    final productContainer=Provider.of<Products>(context,listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('Shop'),
        actions: <Widget>[
          PopupMenuButton(
            icon: Icon(Icons.more_vert),
            //item builder accepts context we donot use that so just simple _ to drop it
            itemBuilder: (_)=>[
              PopupMenuItem(
                child: Text('Only Favorites'),
                value: FilterOptions.Favorites,
              ),
              PopupMenuItem(
                child: Text('Show All'),
                value: FilterOptions.All,
              ),
            ],

            onSelected: (value){
              if(value==FilterOptions.Favorites){
                //show only favorite products
                productContainer.showFavoritesOnly();
              }
              else{
                //show all the products
                productContainer.showAll();
              }
            },

          ),
        ],
      ),
      body: ProductsGrid(),
    );
  }
}



