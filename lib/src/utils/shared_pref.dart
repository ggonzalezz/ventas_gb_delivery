import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ventas_gb_delivery/src/provider/user_provider.dart';
//almacenamiento con persisitencia de datos
class SharedPref {

  //METODO PARA GUARDAR INFORMACION
  void save(String key, value) async {
    final prefs = await await SharedPreferences.getInstance();
    prefs.setString(key, json.encode(value));
  }

  Future<dynamic> read(String key) async {
    final prefs = await SharedPreferences.getInstance();

    if(prefs.getString(key) == null) return null;

    return json.decode(prefs.getString(key));
  }

  Future<bool> contains(String key) async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.containsKey(key);
  }

  Future<bool> remove(String key) async{
    final prefs = await SharedPreferences.getInstance();
    return prefs.remove(key);
  }

  //Salir sessub

  void logout(BuildContext context, String idUser) async{
      UserProvider usersProvider = new UserProvider();
      usersProvider.init(context);
      await usersProvider.logout(idUser);
      await remove('user');
      Navigator.pushNamedAndRemoveUntil(context, 'login', (route) => false);
  }
}