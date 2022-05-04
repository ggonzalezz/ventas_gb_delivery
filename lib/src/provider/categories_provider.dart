import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ventas_gb_delivery/src/api/enviroment.dart';
import 'package:ventas_gb_delivery/src/models/category.dart';
import 'package:ventas_gb_delivery/src/models/response_api.dart';
import 'package:ventas_gb_delivery/src/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:ventas_gb_delivery/src/utils/shared_pref.dart';

class CategoriesProvider {
  String _url = Enviroment.API_DELIVERY;
  String _api = '/api/categories';
  BuildContext context;
  User sessionUser;


  Future init(BuildContext context, User sessionUser){
    this.context = context;
    this.sessionUser = sessionUser;
  }

  Future<List<Category>> getAll() async{
    try{
      Uri url = Uri.http(_url, '$_api/getAll');
      Map<String, String> headers = {
        'Content-type': 'application/json',
        'Authorization': sessionUser.session_token
      };
      final res = await http.get(url, headers: headers);

      //NO AUTORIZADO
      if(res.statusCode == 401){
        Fluttertoast.showToast(msg: 'Tu sesión expiro');
        new SharedPref().logout(context, sessionUser.id);
      }


      final data = json.decode(res.body); //categorias

      //transformar a una lista la data
      Category category = Category.fromJsonList(data);
      return category.toList;

    }catch(e){
      print('Error $e');
      return [];
    }
  }




  Future<ResponseApi> create(Category category) async {
    try{
      Uri url = Uri.http(_url, '$_api/create');
      String bodyParams = json.encode(category);
      Map<String, String> headers = {
        'Content-type': 'application/json',
        'Authorization': sessionUser.session_token
      };
      final res = await http.post(url, headers: headers, body: bodyParams);

      //NO AUTORIZADO
      if(res.statusCode == 401){
        Fluttertoast.showToast(msg: 'Tu sesión expiro');
        new SharedPref().logout(context, sessionUser.id);
      }


      final data = json.decode(res.body);
      ResponseApi responseApi = ResponseApi.fromJson(data);
      return responseApi;
    }catch(e){
      print('Error: $e');
      return null;
    }
  }



}