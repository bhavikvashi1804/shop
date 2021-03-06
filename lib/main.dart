import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/helper/custom_route.dart';


import './screens/product_overview_screen.dart';
import './screens/product_detail_screen.dart';
import './screens/cart_screen.dart';
import './screens/orders_screen.dart';
import './screens/user_products_screen.dart';
import './screens/edit_product_screen.dart';
import './screens/splash_screen.dart';
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

            pageTransitionsTheme: PageTransitionsTheme(
              builders: {
                TargetPlatform.android: CustomPageTransitionBuilder(),
                TargetPlatform.iOS:CustomPageTransitionBuilder(),

              }
            )
            

          ),
          //home: ProductsOverviewScreen(),
          home: auth.isAuth?ProductsOverviewScreen(): 
          FutureBuilder(
            future: auth.tryAutoLogin(),
            builder: (ctx,authResultSS)=>
            authResultSS.connectionState==ConnectionState.waiting?  
            SplashScreen():
            AuthScreen(),
          ),

          routes: {
            //'/':(ctx)=>ProductsOverviewScreen(),
            ProductDetailScreen.routeName:(ctx)=>ProductDetailScreen(),
            CartScreen.routeName:(ctx)=>CartScreen(),
            OrdersScreen.routeName:(ctx)=>OrdersScreen(),
            UserProductsScreen.routeName:(ctx)=>UserProductsScreen(),
            EditProductScreen.routeName:(ctx)=>EditProductScreen(),
          },
        ),
      ),
     
    );
  }
}
