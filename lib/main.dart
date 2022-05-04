import 'package:flutter/material.dart';
import 'package:ventas_gb_delivery/src/pages/client/address/create/client_address_create_page.dart';
import 'package:ventas_gb_delivery/src/pages/client/address/list/client_address_list_page.dart';
import 'package:ventas_gb_delivery/src/pages/client/orders/create/client_orders_create_page.dart';
import 'package:ventas_gb_delivery/src/pages/client/products/list/client_products_list_controller.dart';
import 'package:ventas_gb_delivery/src/pages/client/products/list/client_products_list_page.dart';
import 'package:ventas_gb_delivery/src/pages/client/update/client_update_page.dart';
import 'package:ventas_gb_delivery/src/pages/delibery/orders/list/delibery_orders_list_page.dart';
import 'package:ventas_gb_delivery/src/pages/registro/register_page.dart';
import 'package:ventas_gb_delivery/src/pages/login/login_page.dart';
import 'package:ventas_gb_delivery/src/pages/restaurant/categories/create/restaurant_categories_create_page.dart';
import 'package:ventas_gb_delivery/src/pages/restaurant/orders/list/restaurant_orders_list_page.dart';
import 'package:ventas_gb_delivery/src/pages/restaurant/products/create/restaurant_products_create_page.dart';
import 'package:ventas_gb_delivery/src/pages/roles/roles_page.dart';

import 'package:ventas_gb_delivery/src/utils/my_colors.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = ThemeData();
    return MaterialApp(
      title: 'Vegetales GT',
      debugShowCheckedModeBanner: false,
      initialRoute: 'login',

      routes: {
          'login': (BuildContext context) => LoginPage(),
          'register': (BuildContext context) => RegisterPage(),
          'roles': (BuildContext context) => RolesPage(),

          //ROUTES CLIENT
          'client/products/list': (BuildContext context) => ClientProductsListPage(),
          'client/update': (BuildContext context) => ClientUpdatePage(),
          'client/orders/create': (BuildContext context) => ClientOrdersCreatePage(),
          'client/address/create': (BuildContext context) => ClientAddressCreatePage(),
          'client/address/list': (BuildContext context) => ClientAddressListPage(),
          //ROUTES RESTAURANT
          'restaurant/orders/list': (BuildContext context) => RestaurantOrdersListPage(),
          'restaurant/categories/create': (BuildContext context) => RestaurantCategoriesCreatePage(),
          'restaurant/products/create': (BuildContext context) => RestaurantProductsCreatePage(),
         //ROUTES DELIBERY
         'delibery/orders/list': (BuildContext context) => DeliberyOrdesLisPage(),
      },
      theme: ThemeData(
        //fontFamily: 'montserratBold',
        colorScheme: ColorScheme.light(primary: MyColors.primaryColor),
        appBarTheme: AppBarTheme(elevation: 0)
      ),
    );
  }
}
