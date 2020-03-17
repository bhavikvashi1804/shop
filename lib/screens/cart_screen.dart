import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/cart.dart' show Cart;
import '../widgets/cart_item.dart' ;

class CartScreen extends StatelessWidget {

  static const routeName='/cart';

  @override
  Widget build(BuildContext context) {
    final Cart cart=Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
      ),

      body: Column(
        children: <Widget>[
          Card(
            margin: EdgeInsets.all(15),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Total',
                    style: TextStyle(fontSize: 20),
                  ),
                  Spacer(
                    //spacer takes all available space
                  ),
                  Chip(
                    label: Text(
                      '\$  ${cart.totalAmount}',
                      style: TextStyle(
                        color: Theme.of(context).primaryTextTheme.title.color, 
                      ), 
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  FlatButton(
                    onPressed:(){
                    }, 
                    child: Text(
                      'ORDER NOW',
                    ),
                    textColor: Theme.of(context).primaryColor,
                  ),
                ],
              ),
            ),
          ),

          SizedBox(
            height: 10,
          ),

          Expanded(
            child: ListView.builder(
              itemBuilder: (ctx,index)=> CartItem(
               id: cart.items.values.toList()[index].id,
               price: cart.items.values.toList()[index].price,
               quantity: cart.items.values.toList()[index].quantity,
               title: cart.items.values.toList()[index].title,
              ),
              itemCount: cart.itemCount,
            ), 
          ),
        ],
      ),
      
    );
  }
}