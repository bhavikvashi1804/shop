import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../provider/products_provider.dart';
import '../widgets/user_product_item.dart';
import '../widgets/app_drawer.dart';


class UserProductsScreen extends StatelessWidget {

  static const routeName='/user-products';

  @override
  Widget build(BuildContext context) {

    final productData=Provider.of<Products>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Products'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add), 
            onPressed: (){

            }
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: productData.items.length,
          itemBuilder: (ctx,i)=>Column(
            children: <Widget>[
              UserProductItem(
                title: productData.items[i].title,
                imageUrl: productData.items[i].imageUrl,
              ),
              Divider(),
             
            ],
          ),
        ), 
      ),
      
      
    );
  }
}