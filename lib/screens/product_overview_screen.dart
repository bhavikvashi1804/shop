import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/provider/cart.dart';

import '../widgets/products_grid.dart';
import '../widgets/badge.dart';

enum FilterOptions{
  Favorites,
  All,
}

class ProductsOverviewScreen extends StatefulWidget {
  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {


  var _showOnlyFavorites=false;

  @override
  Widget build(BuildContext context) {
    
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

              setState(() {
                if(value==FilterOptions.Favorites){
                //show only favorite products
                // in last logic provider will return the filter result in all the pages 
                //that is not required , in this page we want filter data - other page we want all data
                //so convert this to Statefull widget
                _showOnlyFavorites=true;
                }
                else{
                  //show all the products
                  _showOnlyFavorites=false; 
                }  
              });
              
            },

          ),
          Consumer<Cart> (
            builder: (context, value, child1) => Badge(
              child: child1, 
              value: value.itemCount.toString(),
            ),
            child: IconButton(
             icon: Icon(Icons.shopping_cart),
             onPressed: (){
               //open shooping cart page

             }, 
            ),
          ),
        ],
      ),
      body: ProductsGrid(_showOnlyFavorites),
    );
  }
}



