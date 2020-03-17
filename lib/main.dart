import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import './screens/product_overview_screen.dart';
import './screens/product_detail_screen.dart';
import './provider/products_provider.dart';
import './provider/cart.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: Products()),
        ChangeNotifierProvider.value(value: Cart()),
      ],
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
