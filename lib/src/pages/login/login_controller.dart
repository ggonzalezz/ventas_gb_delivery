import 'package:flutter/material.dart';
import 'package:ventas_gb_delivery/src/models/response_api.dart';
import 'package:ventas_gb_delivery/src/models/user.dart';
import 'package:ventas_gb_delivery/src/provider/user_provider.dart';
import 'package:ventas_gb_delivery/src/utils/my_snackbar.dart';
import 'package:ventas_gb_delivery/src/utils/shared_pref.dart';
class LoginController{
  BuildContext context;
  //casteo
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  UserProvider userProvider =  new UserProvider();

  //persistencia
  SharedPref _sharedPref = new SharedPref();

  Future init(BuildContext context) async {
    this.context = context;
    await userProvider.init(context);

    User user = User.fromJson(await _sharedPref.read('user') ?? {});

    if(user?.session_token != null){
      if(user.roles.length > 1){
        Navigator.pushNamedAndRemoveUntil(context, 'roles', (route) => false);
      }else{
        Navigator.pushNamedAndRemoveUntil(context, user.roles[0].route, (route) => false);
      }

    }

  }
  void goToRegisterPage(){
    Navigator.pushNamed(context, 'register');
  }
  void login() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    ResponseApi responseApi = await userProvider.login(email, password);
    print('Respuesta: ${responseApi?.toJson()}');
    if(responseApi.success){
      User user = User.fromJson(responseApi.data);
      _sharedPref.save('user', user.toJson());
      print('USUARIO LOGUEADO: ${user.toJson()}');
      if(user.roles.length > 1){
        Navigator.pushNamedAndRemoveUntil(context, 'roles', (route) => false);
      }else{
        Navigator.pushNamedAndRemoveUntil(context, user.roles[0].route, (route) => false);
      }

    }else{
      MySnackbar.show(context, responseApi.message);
    }

  }
}