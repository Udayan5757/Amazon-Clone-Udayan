import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_amazon_clone/common/widgets/bottom_bar.dart';
import '../providers/user_provider.dart';
import 'package:provider/provider.dart';
import '../constants/httpErrorHandling.dart';
import '../constants/utils.dart';
import '../models/user.dart';
import 'package:http/http.dart' as http;
import '../constants/global_variables.dart';
import 'package:shared_preferences/shared_preferences.dart';
class AuthService{
  void signUpUser({
    required BuildContext context,
    required String email,
    required String name,
    required String password,
  }) async {
    try{
      User user = User(
          id: '',
          name: name,
          email: email,
          password: password,
          type: '',
          address: '',
          token: '',
          cart: [],
          wishList: [],
          );
      http.Response res = await http.post(
        Uri.parse('$uri/api/signup'),
        body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
    httpErrorHandling(response: res, context: context, onSuccess: (){
      showSnackBar(context, 'Account created! Login with same credentials!' );
    });
    }catch(e){
      showSnackBar(context, e.toString());
    }
  }
  void signInUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try{
      http.Response res = await http.post(
        Uri.parse('$uri/api/signin'),
        body: jsonEncode({
          'email':email,
          'password':password,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
    httpErrorHandling(
      response: res,context: context,
      onSuccess: () async {
        SharedPreferences pref = await  SharedPreferences.getInstance();
        Provider.of<UserProvider>(context, listen: false).setUser(res.body);
        await pref.setString('x-auth-token',jsonDecode(res.body)["token"]);
        Navigator.pushNamedAndRemoveUntil(
            context,
            BottomBar.routeName,
            (route) => false,
          );
          
      });
    }catch(e){
      showSnackBar(context, e.toString());
    }
  }
  Future<bool?> getUserData({
    required BuildContext context,
  }) async {
    try{
      SharedPreferences pref = await SharedPreferences.getInstance();
      String? token =  pref.getString('x-auth-token');
      if(token==null){
        await pref.setString('x-auth-token', '');
      }
      var tokenResponse = await http.post(
        Uri.parse('$uri/tokenIsValid'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token!
        },
      );
      var response = jsonDecode(tokenResponse.body);
      if(response==true){
        http.Response userRes = await http.get(Uri.parse('$uri/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token,
        },
        );
        var userProvider = Provider.of<UserProvider>(context,listen: false);
        userProvider.setUser(userRes.body);
        if(token==null) return false;
        else return true;
      }
      
    }catch(e){
      showSnackBar(context, e.toString());
    }
  }
}