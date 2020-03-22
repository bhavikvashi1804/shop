import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


import './cart.dart';



class OrderItem{

  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem({this.id,this.amount,this.products,this.dateTime});





}


class Orders with ChangeNotifier{


  final String authToken;


  List<OrderItem> _orders=[];

  Orders(this.authToken,this._orders);

  List<OrderItem> get orders{
    return [..._orders];
  }


  Future<void> fetchAndSetOrders() async {
    final url='https://shop-demo-bd6d3.firebaseio.com/orders.json?auth=$authToken';
    final response = await http.get(url);
    final List<OrderItem> loadedOrders = [];
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    if (extractedData == null) {
      return;
    }
    extractedData.forEach((orderId, orderData) {
      loadedOrders.add(
        OrderItem(
          id: orderId,
          amount: orderData['amount'],
          dateTime: DateTime.parse(orderData['dateTime']),
          products: (orderData['products'] as List<dynamic>)
              .map(
                (item) => CartItem(
                      id: item['id'],
                      price: item['price'],
                      quantity: item['quantity'],
                      title: item['title'],
                    ),
              )
              .toList(),
        ),
      );
    });
    _orders = loadedOrders.reversed.toList();
    notifyListeners();
  }

  

  Future<void> addOrder(List<CartItem> cartProducts,double price)async{ 

    final timeStamp=DateTime.now();

    try{

      final url='https://shop-demo-bd6d3.firebaseio.com/orders.json?auth=$authToken';
      final response = await http.post(
        url,
        body:json.encode(
          {
            'amount':price,
            'dateTime':timeStamp.toIso8601String(),
            'products': cartProducts.map((cp) =>
              {
                'id':cp.id,
                'title':cp.title,
                'price':cp.price,
                'quantity':cp.quantity,
              }
            ).toList(),

          }

        ),
      );

      _orders.insert(0,
        OrderItem(
          dateTime: timeStamp,
          id:json.decode(response.body) ['name'],
          amount: price,
          products: cartProducts,
        )
      );

      notifyListeners();
    }
    catch(error){
      print(error);
      throw(error);
    }  
  }
}