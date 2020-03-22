import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Product with ChangeNotifier{ 


  final String id;
  final String title;
  final String  description;
  final double price;
  final String imageUrl;
  bool isFavorite;




  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
    this.isFavorite=false,
  });


  void _setFavVal(bool newVal){
    isFavorite=newVal;
    notifyListeners();
  }

  Future<void> toggleFavoriteStatus(String token) async{
    final oldFavStatus=isFavorite;
    isFavorite=!isFavorite;
    notifyListeners();

    try{
      final url='https://shop-demo-bd6d3.firebaseio.com/products/$id.json?auth=$token';
      final response=await http.patch(
        url,
        body: json.encode({
          'isFavorite':isFavorite,
        }),
      );

      if(response.statusCode>=400){
         _setFavVal(oldFavStatus);
      }
    }
    catch(error){
      _setFavVal(oldFavStatus);
    }
    
  }



}