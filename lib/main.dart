import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import './screens/product_overview_screen.dart';
import './screens/product_detail_screen.dart';
import './provider/products_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      
      //we need to provide provider to all interesting parties
      //hence we wrap the Material app with ChangeNotifierProvider
      //ChangeNotifierProvider class comes under package of provider
      //it  allows to register class to which you can that listen in child wddgets
      //whenever that class update the widgets  which are listening only these are rebuild
      //for that you have to provide create methods in older version it is named ad builder 

      create:(ctx)=>Products(),

      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Shop App',
        theme: ThemeData(
         
          primarySwatch: Colors.purple,
          accentColor: Colors.deepOrange,

          fontFamily: 'Lato',

        ),
        //home: ProductsOverviewScreen(),

        routes: {
          '/':(ctx)=>ProductsOverviewScreen(),
          ProductDetailScreen.routeName:(ctx)=>ProductDetailScreen(),
        },
      ),
    );
  }
}
