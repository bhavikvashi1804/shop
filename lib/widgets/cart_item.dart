import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/provider/cart.dart';

class CartItem extends StatelessWidget {

  final String id,title;
  final int quantity;
  final double price;
  final String productID;

  CartItem({this.id,this.title,this.productID,this.price,this.quantity});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      direction: DismissDirection.endToStart,
      //only allow swipe right to left
      onDismissed: (direction){
        Provider.of<Cart>(context,listen: false).removeItem(productID);

      },
      confirmDismiss: (direction){
        //this is confirm dismiss means before perform confirm dismiss return true or false on this decision will be taken
        //confirmDismiss takes argument as direction
        //confirmDismiss requries to return Future Bool , show Dialog return the Future<bool>
        return showDialog(
          context: context,
          builder: (ctx)=>AlertDialog(
            title: Text('Are you sure?'),
            content: Text('Do you want to remove the item from the cart?'),
            actions: <Widget>[
              FlatButton(
                onPressed: ()=>Navigator.of(ctx).pop(false), 
                child: Text('No')
              ),
              FlatButton(
                onPressed: ()=>Navigator.of(ctx).pop(true), 
                child: Text('Yes'),
              ),
              
            ],

          ),
        );
      },
      background: Container(
        padding: EdgeInsets.only(right: 20),
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4
        ),
        color:Theme.of(context).errorColor,
        alignment: Alignment.centerRight,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
      ),
      child: Card(
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4
        ),
        child: Padding(
          padding: EdgeInsets.all(8) ,
          child: ListTile(
            leading: CircleAvatar(
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: FittedBox(
                  child: Text(
                    '\$ $price'
                  ),
                ),
              ),
            ),
            title: Text(
              title,
            ),
            subtitle: Text(
              'Total: \$ ${(price*quantity)}'
            ),
            trailing: Text(
              '$quantity x'
            ),
          ),
        ),
        
      ),
    );
  }
}