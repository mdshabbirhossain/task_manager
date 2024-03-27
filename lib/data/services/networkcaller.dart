import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';

import 'package:http/http.dart';
import 'package:task_manager/app.dart';
import 'package:task_manager/data/models/response_object.dart';
import 'package:task_manager/presentation/screens/auth/signin_screen.dart';

import '../../presentation/controllers/auth_controller.dart';
class NetworkCaller {
  static Future<ResponseObject> getRequest (String url) async{
   log(url);
    log(AuthController.accessToken.toString());
    try{
      final Response response = await get(Uri.parse(url),headers: {
        'token': AuthController.accessToken?? '',
      });
      log(response.statusCode.toString());
      log(response.body.toString());

      if (response.statusCode == 200) {
        final decodedResponse = jsonDecode(response.body);
        return ResponseObject(
            statusCode: 200, responseBody: decodedResponse, isSuccess: true);
      } else if (response.statusCode==401) {
        return ResponseObject(
            statusCode: response.statusCode, responseBody: '', isSuccess: false);
      }



      else {
        return ResponseObject(
            statusCode: response.statusCode, responseBody: '', isSuccess: false);
      }
    }catch(e){
      log(e.toString());
      return ResponseObject(statusCode: -1 , responseBody: '', isSuccess: false, errorMessage: e.toString());

    }
  }

  static Future<ResponseObject> postRequest (String url, Map<String, dynamic> body, {bool fromSignIn= false}) async{
    try{
      log(url);
      log(body.toString());

      final Response response = await post(Uri.parse(url), body: jsonEncode(body), headers: {
        'content-type': 'application/json' , 'token': AuthController.accessToken?? '',
      });
      log(response.statusCode.toString());
      log(response.body.toString());

      if (response.statusCode == 200) {
        final decodedResponse = jsonDecode(response.body);
        return ResponseObject(
            statusCode: 200, responseBody: decodedResponse, isSuccess: true);
      }else if(response.statusCode==401){
        if(fromSignIn) {
          return ResponseObject(
              statusCode: response.statusCode, responseBody: '',
              isSuccess: false, errorMessage: 'Email or Password is incorrect');
        }else{
          _moveToSignIn();
          return ResponseObject(
              statusCode: response.statusCode, responseBody: '', isSuccess: false);
        }

      }


      else {
        return ResponseObject(
            statusCode: response.statusCode, responseBody: '', isSuccess: false);
      }
    }catch(e){
      log(e.toString());
      return ResponseObject(statusCode: -1 , responseBody: '', isSuccess: false, errorMessage: e.toString());

    }
  }
  static void _moveToSignIn()async{
    await AuthController.clearUserData();
    Navigator.pushAndRemoveUntil(TaskManager.navigatorKey.currentState!.context, MaterialPageRoute(builder: (context)=> SignInScreen()), (route) => false);

  }
}