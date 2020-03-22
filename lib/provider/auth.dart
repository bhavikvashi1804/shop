import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


import '../models/http_exception.dart';

class Auth with ChangeNotifier{
  String _token;
  //after 1h it expires
  DateTime _expiryDate;
  String _userID;
  Timer _authTimer;




  String get userID{
    return _userID;
  }
  

  //key = AIzaSyBf_mkEI8UwDly7MTmBqZliMZlYRi2IaQg

   Future<void> _authenticate(
      String email, String password, String urlSegment) async {
    final url =
        'https://www.googleapis.com/identitytoolkit/v3/relyingparty/$urlSegment?key=AIzaSyBf_mkEI8UwDly7MTmBqZliMZlYRi2IaQg';
    
    
    try{
      final response = await http.post(
        url,
        body: json.encode(
          {
            'email': email,
            'password': password,
            'returnSecureToken': true,
          },
        ),
      );
      print(json.decode(response.body));

      final responseData=json.decode(response.body);
      if(responseData['error']!=null){
        throw HttpException(responseData['error']['message']);
      }
      _token = responseData['idToken'];
      _userID = responseData['localId'];
      _expiryDate = DateTime.now().add(
        Duration(
          seconds: int.parse(
            responseData['expiresIn'],
          ),
        ),
      );
      _autoLogout();
      
      notifyListeners();



    }
    catch(error){
      throw error;

    }
    
   
  }

  Future<void> signup(String email, String password) async {
    return _authenticate(email, password, 'signupNewUser');
  }

  Future<void> login(String email, String password) async {
    return _authenticate(email, password, 'verifyPassword');
  }


  bool get isAuth{
    return token!=null;
  }

  String get token{
    if(_expiryDate!=null && _expiryDate.isAfter(DateTime.now()) && _token!=null){
      return _token;
    }
    else{
      return null;
    }
  }

  void logout(){
    _userID=null;
    _token=null;
    _expiryDate=null;
    if(_authTimer!=null){
      _authTimer.cancel();
      _authTimer=null;
    }
    notifyListeners();

  }


  void _autoLogout(){
    
    if(_authTimer!=null){
      _authTimer.cancel();
    }

    final timeToExpiry=_expiryDate.difference(DateTime.now()).inSeconds;
    _authTimer=Timer(
      Duration( 
        //seconds: 10 for testing
        seconds: timeToExpiry,
      ),
      logout
    );
  }
}