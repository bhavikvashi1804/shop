import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:math';
import '../provider/orders.dart' as odr;

class OrderItem extends StatefulWidget {

 
  final odr.OrderItem  order;

  OrderItem({this.order});

  @override
  _OrderItemState createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {

  var expanded=false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      height: expanded?min(widget.order.products.length*20.0 +110.0,200.0):95,
      // remeber this 
      child: Card(
        margin: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            ListTile(
              title: Text(
                '\$ ${widget.order.amount}'
              ),
              subtitle: Text(
                DateFormat('dd/MM/yyyy hh:mm').format(widget.order.dateTime),
              ),
              trailing: IconButton(
                icon: Icon(expanded?Icons.expand_less:Icons.expand_more), 
                onPressed: (){
                  setState(() {
                    expanded=!expanded;
                  });

                }
              ),
            ),
            AnimatedContainer(
              duration: Duration(milliseconds: 300),
              padding: EdgeInsets.symmetric(
                horizontal:16,
                vertical: 4,
              ),
              height:expanded?min(widget.order.products.length*20.0 +10.0,100.0):0,
              child:ListView(
                children: widget.order.products.map(
                  (prod)=> Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        prod.title,
                        style:TextStyle(
                          fontSize:18,
                          fontWeight:FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${prod.quantity}x \$ ${prod.price}',
                        style:TextStyle(
                          fontSize:18,
                          color:Colors.grey,
                        ),

                      ),

                    ],
                  )

                ).toList(),
              )

            ),
          ],
        ),
        
      ),
    );
  }
}