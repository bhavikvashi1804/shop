import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../provider/products_provider.dart';

class ProductDetailScreen extends StatelessWidget {

  static const String routeName='/product-detail';

  
  //here simple route creates problem
  //the problem is you have to pass the data which is not required by second screen but required by 3rd screen
  //so second screen have overhead of that extra data

  @override
  Widget build(BuildContext context) {

    final String productID =ModalRoute.of(context).settings.arguments as String;
    //here we obtain productID
    //now we need to extract data of our ID for that we requires central state management


    //using Provider 
    final loadedProduct =Provider.of<Products>(context,listen: false).findByID(productID);
    //listen false refers to when data change and when we perform notify this widget will not rebuild 
    //in this screen we donot interest in update of data hence we set listen to false 
    //by default listen value is true
    //in products_grid.dart we want to listen update so have not specify listen to false

    return Scaffold(
      //appBar: AppBar(
      //  title: Text(loadedProduct.title),
      //),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title:Text(loadedProduct.title) ,
              background: Hero(
                tag: loadedProduct.id,
                child: Image.network(
                  loadedProduct.imageUrl,
                  fit: BoxFit.cover,  
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                SizedBox(
                  height: 10,
                ),
                Text(
                  '\$ ${loadedProduct.price}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 20,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  child: Text(
                    loadedProduct.description,
                    textAlign: TextAlign.center,
                    softWrap: true,
                  ),
                ),
                SizedBox(
                  height: 800,
                  //to check which sliver list
                )
              ],
            ) ,

          ),
        ],
      ),
      
    );
  }
}