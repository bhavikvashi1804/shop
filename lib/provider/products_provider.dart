import 'package:flutter/cupertino.dart';


import '../model/product.dart';

class Products with ChangeNotifier{


  List<Product> _items=[
    Product(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Product(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    ),
    Product(
      id: 'p3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageUrl:
          'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    ),
    Product(
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    ),
  ];


  List<Product> get items{
    //do not returns _items directly 
    //returns copy of _items
    //if I return _items then it returns address of _items and we can change _items by using that address
    //that why we donot require to return address
    return [..._items];
  }

  void addProduct(){
    //_items.add(value);
    //we need to add product
    //to add product _items.add(value)
    //after adding item please notify listeners



    notifyListeners();
    //notifyListeners notify all listeners that items are updated when we perform update 
    //notifyListeners is provided by ChangeNotifier

  }

  Product findByID(String id){
     return items.firstWhere((element) => element.id==id);
  }

}