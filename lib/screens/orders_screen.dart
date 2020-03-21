import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/orders.dart' show Orders;
import '../widgets/order_item.dart';
import '../widgets/app_drawer.dart';


class OrdersScreen extends StatelessWidget {

  static const routeName='/orders';

  

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),

      drawer: AppDrawer(),

      body: FutureBuilder(
        future: Provider.of<Orders>(context,listen: false).fetchAndSetOrders(),
        builder: (ctx,dataSnapShot){
          if(dataSnapShot.connectionState==ConnectionState.waiting){
            return Center(child: CircularProgressIndicator(),);
          }
          else{
            if(dataSnapShot.error!=null){
              return Center(
                child:Text('An error occured!')
              );
            }
            else{
              return Consumer<Orders>(
                builder: (context,ordersData, child) =>ListView.builder(
                  itemCount: ordersData.orders.length ,
                  itemBuilder: (ctx,i)=>OrderItem(
                    order: ordersData.orders[i],
                  ),
                ),
              ); 
            }
          }
        },
      ), 
    );
  }
}