import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


import './product.dart';
import '../models/http_exception.dart';

class Products with ChangeNotifier{


  final String authToken;
  final String userID;

  


  List<Product> _items=[

    /*
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
    */
  ];


  Products(this.authToken,this.userID,this._items);

  List<Product> get items{
    //do not returns _items directly 
    //returns copy of _items
    //if I return _items then it returns address of _items and we can change _items by using that address
    //that why we donot require to return address

    return [..._items];
  
  }

  List<Product> get favoriteItems{
    return _items.where((element) => element.isFavorite).toList();
  }

  


  Future<void> addProduct(Product p1) async{
  
    final url='https://shop-demo-bd6d3.firebaseio.com/products.json?auth=$authToken';
    try{
      final response=await http.post(
        url,
        body: json.encode(
          {
            'title':p1.title,
            'description':p1.description,
            'price':p1.price,
            'imageURL':p1.imageUrl,
            'creatorID':userID,
            //'isFavorite':p1.isFavorite,
          }
        ),
      );

      final Product newProduct=Product(
        id: json.decode(response.body)['name'],
        title: p1.title,
        description: p1.description,
        price: p1.price,
        imageUrl: p1.imageUrl, 
      );
      _items.add(newProduct);
      notifyListeners();

    }
    catch(error){
      print('error');
      throw('error');
    }
    
    
  }


  Future<void> fetchAndSetProducts([bool filterByUser=false])async{

    final filterString= filterByUser?'orderBy="creatorID"&equalTo="$userID"':'';

    final url='https://shop-demo-bd6d3.firebaseio.com/products.json?auth=$authToken&$filterString';
    try{
      final response=await http.get(url);
      //print(json.decode(response.body));
      final extractedData=json.decode(response.body) as Map<String,dynamic>;
      final List<Product> loadedProducts=[]; 

      if(extractedData==null){
        return;
      }

      final url1='https://shop-demo-bd6d3.firebaseio.com/userFavs/$userID.json?auth=$authToken';
      final favResponse=await http.get(url1);
      final favData=json.decode(favResponse.body);

      extractedData.forEach((key, value) { 
        //here key is prod id
        loadedProducts.add(Product(
          id: key,
          title: value['title'],
          description: value['description'],
          price: value['price'].toDouble(),
          imageUrl: value['imageURL'],
          isFavorite:
              favData == null ? false : favData[key] ?? false,
          //isFavorite: false,
        ));

      });

      _items=loadedProducts;
      notifyListeners();
    }
    catch(error){
      print(error);
      throw error;
    }
  }

  Future<void> updateProduct(String productID,Product newProduct)async{
    final existProductIndex =_items.indexWhere((element) => element.id==productID);
    if(existProductIndex>=0){
      final url='https://shop-demo-bd6d3.firebaseio.com/products/$productID.json?auth=$authToken';
      await http.patch(
        url,
        body:json.encode({
          'title':newProduct.title,
          'description':newProduct.description,
          'price':newProduct.price,
          'imageURL':newProduct.imageUrl,
          //please donot change isFav on server
        }),
      );
      _items[existProductIndex]=newProduct;
      notifyListeners();
    }
  }


  Future<void> deleteProduct(String productID)async{
    final url='https://shop-demo-bd6d3.firebaseio.com/products/$productID.json?auth=$authToken';
    //_items.removeWhere((element) => element.id==productID);
    final existingProductIndex=_items.indexWhere((product)=>product.id==productID);
    var existingProduct=_items[existingProductIndex];
    
    //above 3 three line is same as removeWhere but we have deleted item in existingProduct in new approach
    final response=await http.delete(url);
    if(response.statusCode>=400){
        _items.insert(existingProductIndex, existingProduct);
        notifyListeners();
        throw HttpException('Could not delete the product');
        //to make sure that product will remain as it is if problem is occured
    }
    existingProduct=null;
    _items.removeAt(existingProductIndex);
    notifyListeners();
    //here in delete it still work because it never throws an error 
  }

  Product findByID(String id){
     return items.firstWhere((element) => element.id==id);
  }

}