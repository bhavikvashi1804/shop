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
import './provider/auth.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: Auth()),
        ChangeNotifierProxyProvider<Auth,Products>(
          builder :(ctx,auth,previousProducts) =>Products(
            auth.token,
            auth.userID,
            previousProducts==null?[]:previousProducts.items
          ),
        ),
        ChangeNotifierProvider.value(value: Cart()),
        ChangeNotifierProxyProvider<Auth,Orders>(
           builder :(ctx,auth,previousProducts) =>Orders(
            auth.token,
            auth.userID,
            previousProducts==null?[]:previousProducts.orders,
          ),

        ),
        
      ],
      child: Consumer<Auth>(
        builder: (ctx,auth,_)=> MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Shop App',
          theme: ThemeData(
          
            primarySwatch: Colors.purple,
            accentColor: Colors.deepOrange,

            fontFamily: 'Lato',

          ),
          //home: ProductsOverviewScreen(),
          home: auth.isAuth?ProductsOverviewScreen(): AuthScreen(),

          routes: {
            //'/':(ctx)=>ProductsOverviewScreen(),
            ProductDetailScreen.routeName:(ctx)=>auth.isAuth?ProductDetailScreen():AuthScreen(),
            CartScreen.routeName:(ctx)=>auth.isAuth?CartScreen():AuthScreen(),
            OrdersScreen.routeName:(ctx)=>auth.isAuth?OrdersScreen():AuthScreen(),
            UserProductsScreen.routeName:(ctx)=>auth.isAuth?UserProductsScreen():AuthScreen(),
            EditProductScreen.routeName:(ctx)=>auth.isAuth?EditProductScreen():AuthScreen(),
          },
        ),
      ),
     
    );
  }
}
