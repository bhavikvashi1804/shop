import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import './screens/product_overview_screen.dart';
import './screens/product_detail_screen.dart';
import './screens/cart_screen.dart';
import './screens/orders_screen.dart';
import './screens/user_products_screen.dart';
import './screens/edit_product_screen.dart';
import './screens/auth_screen.dart';
import './provider/products_provider.dart';
import './provider/cart.dart';
import './provider/orders.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: Products()),
        ChangeNotifierProvider.value(value: Cart()),
        ChangeNotifierProvider.value(value: Orders()),
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
        home: AuthScreen(),

        routes: {
          //'/':(ctx)=>ProductsOverviewScreen(),
          ProductDetailScreen.routeName:(ctx)=>ProductDetailScreen(),
          CartScreen.routeName:(ctx)=>CartScreen(),
          OrdersScreen.routeName:(ctx)=>OrdersScreen(),
          UserProductsScreen.routeName:(ctx)=>UserProductsScreen(),
          EditProductScreen.routeName:(ctx)=>EditProductScreen(),
        },
      ),
    );
  }
}
