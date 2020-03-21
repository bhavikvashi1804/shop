import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../provider/products_provider.dart';
import '../widgets/user_product_item.dart';
import '../widgets/app_drawer.dart';
import '../screens/edit_product_screen.dart';


class UserProductsScreen extends StatelessWidget {

  static const routeName='/user-products';


  Future<void> _refreshProducts(BuildContext context) async{
    await Provider.of<Products>(context).fetchAndSetProducts();
  }

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
              Navigator.of(context).pushNamed(EditProductScreen.routeName);

            }
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: RefreshIndicator(
        onRefresh: ()=>_refreshProducts(context) ,
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListView.builder(
            itemCount: productData.items.length,
            itemBuilder: (ctx,i)=>Column(
              children: <Widget>[
                UserProductItem(
                  title: productData.items[i].title,
                  imageUrl: productData.items[i].imageUrl,
                  id: productData.items[i].id,
                ),
                Divider(),
               
              ],
            ),
          ), 
        ),
      ),
      
      
    );
  }
}