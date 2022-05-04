import 'package:flutter/material.dart';
import 'package:ventas_gb_delivery/src/models/user.dart';
import 'package:ventas_gb_delivery/src/utils/shared_pref.dart';

class DeliberyOrdersListController {

  BuildContext context;

  SharedPref _sharedPref = new SharedPref();
  GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();

  Function refresh;
  //datos del usuario en el menu
  User user;

  Future init(BuildContext context, Function refresh) async{
    this.context = context;
    this.refresh = refresh;
    //parse el nombre del usuario para mostrarlo en la page
    user = User.fromJson(await _sharedPref.read('user'));
    refresh();
  }

  void logout(){
    _sharedPref.logout(context, user.id);
  }

  void openDrawer(){
    key.currentState.openDrawer();
  }
  void goToRoles(){
    Navigator.pushNamedAndRemoveUntil(context, 'roles', (route) => false);
  }
}
