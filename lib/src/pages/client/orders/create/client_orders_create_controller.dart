import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ventas_gb_delivery/src/models/product.dart';
import 'package:ventas_gb_delivery/src/utils/shared_pref.dart';
class ClientOrdersCreateController{

  BuildContext context;
  Function refresh;
  Product product;

  int counter = 1;
  double productPrice;

  //Sharpref para guardar precios y cantidades
  SharedPref _sharedPref = new SharedPref();

  //LISTA PARA GUARDAR PRODUCTOS SELECCIONADOS
  List<Product> selectedProducts = [];
  double total = 0;

  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    selectedProducts = Product.fromJsonList(await _sharedPref.read('order')).toList;

    getTotal();
    refresh();

  }
  void getTotal(){
    total = 0;
    selectedProducts.forEach((product) {
       total = total + (product.quantity * product.price);
    });

    refresh();
  }

  void addItem(Product product){
    int index = selectedProducts.indexWhere((p) => p.id == product.id);
    selectedProducts[index].quantity = selectedProducts[index].quantity +1;
    _sharedPref.save('order', selectedProducts);
    getTotal();
  }

  void removeItem(Product product){
    if(product.quantity > 1){
      int index = selectedProducts.indexWhere((p) => p.id == product.id);
      selectedProducts[index].quantity = selectedProducts[index].quantity - 1;
      _sharedPref.save('order', selectedProducts);
      getTotal();
    }
  }

  void deleteItem(Product product){
    selectedProducts.removeWhere((p) => p.id == product.id);
    _sharedPref.save('order', selectedProducts);
    getTotal();
  }

  void goToAddress(){
    Navigator.pushNamed(context, 'client/address/list');
  }















}