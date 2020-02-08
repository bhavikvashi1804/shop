import 'package:flutter/material.dart';

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

    return Scaffold(
      appBar: AppBar(
        title: Text('Product Name'),
      ),
      body: Container(),
      
    );
  }
}