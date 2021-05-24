import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';

class Authservice {
  Dio dio = new Dio();

  login(name, password) async {
    try {
      return await dio.post(
        'https://flutterauthapp-jhf.herokuapp.com/authenticate',
        data: {
          "name": name,
          "password": password,
        },
        options: Options(
          contentType: Headers.jsonContentType,
        ),
      );
    } on DioError catch (err) {
      Fluttertoast.showToast(
        msg: err.response.data['msg'],
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  signup(name, password) async {
    try {
      return await dio.post(
        'https://flutterauthapp-jhf.herokuapp.com/adduser',
        data: {
          "name": name,
          "password": password,
        },
        options: Options(
          contentType: Headers.jsonContentType,
        ),
      );
    } on DioError catch (err) {
      Fluttertoast.showToast(
        msg: err.response.data['msg'],
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  getinfo(token) async {
    dio.options.headers['Authorization'] = 'Bearer $token';
    return await dio.get('https://flutterauthapp-jhf.herokuapp.com/getinfo');
  }
}
