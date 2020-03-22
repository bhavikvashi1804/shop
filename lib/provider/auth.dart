import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Auth with ChangeNotifier{
  String _token;
  //after 1h it expires
  DateTime _expiryDate;
  String _userID;




  

  //key = AIzaSyBf_mkEI8UwDly7MTmBqZliMZlYRi2IaQg

   Future<void> _authenticate(
      String email, String password, String urlSegment) async {
    final url =
        'https://www.googleapis.com/identitytoolkit/v3/relyingparty/$urlSegment?key=AIzaSyBf_mkEI8UwDly7MTmBqZliMZlYRi2IaQg';
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
  }

  Future<void> signup(String email, String password) async {
    return _authenticate(email, password, 'signupNewUser');
  }

  Future<void> login(String email, String password) async {
    return _authenticate(email, password, 'verifyPassword');
  }
}