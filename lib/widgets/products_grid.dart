import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/products_provider.dart';
import '../widgets/product_item.dart';


class ProductsGrid extends StatelessWidget {

  

  

  @override
  Widget build(BuildContext context) {

    //user provider and obtain Products ref
    final productsData = Provider.of<Products>(context);
    //use the getter and obtain list of items 
    final products=productsData.items;
    


    return GridView.builder(
      padding: const EdgeInsets.all(10),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3/2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10, 
      ), 
      itemBuilder: (ctx,index)=>ProductItem(
        id: products[index].id,
        title: products[index].title,
        imageUrl: products[index].imageUrl,
      ),
      itemCount: products.length,
    );
  }
}
