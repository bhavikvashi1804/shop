import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Auth with ChangeNotifier{
  String _token;
  //after 1h it expires
  DateTime _expiryDate;
  String _userID;




  Future<void> signup(String email, String password) async {
    const url='https://www.googleapis.com/identitytoolkit/v3/relyingparty/signupNewUser?key=AIzaSyBf_mkEI8UwDly7MTmBqZliMZlYRi2IaQg';
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
}