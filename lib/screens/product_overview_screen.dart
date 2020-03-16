import 'package:flutter/material.dart';

import '../widgets/products_grid.dart';

class ProductsOverviewScreen extends StatelessWidget {
  
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
                value: 0,
              ),
              PopupMenuItem(
                child: Text('Show All'),
                value: 1,
              ),
            ],

            onSelected: (value) => print(value),
          ),
        ],
      ),
      body: ProductsGrid(),
    );
  }
}



