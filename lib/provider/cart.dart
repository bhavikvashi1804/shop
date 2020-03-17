import 'package:flutter/cupertino.dart';


class CartItem{
  final String id;
  final String title;
  final int quantity;
  final double price;

  CartItem({this.id,this.title,this.quantity,this.price});
}

class Cart with ChangeNotifier{
  
  Map<String,CartItem> _items;

  Map<String,CartItem> get items{
    return {..._items};
  }

  void addProduct(String productID,String title,double price){
    //check if already item is there
    if(_items.containsKey(productID)){
      //increment quantity
      _items.update(
        productID, 
        (value) => CartItem(
          id: value.id,
          title: value.title,
          price: value.price,
          quantity: value.quantity+1,
          //items.update find productID item  from list of items and provide item as result in value 
          //value if existing item value 
          //you need to use the existing item value and update it (q++)     
        ),
      );
    }
    else{
      //add the product to the cart
      _items.putIfAbsent(
        productID,
        ()=>CartItem(
          id: DateTime.now().toString(),
          title: title,
          price: price,
          quantity: 1,
        ),
      );
      
    }

  }

}