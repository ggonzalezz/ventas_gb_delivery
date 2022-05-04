import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ventas_gb_delivery/src/models/product.dart';
import 'package:ventas_gb_delivery/src/utils/shared_pref.dart';
class ClientProductsDetailController{

  BuildContext context;
  Function refresh;
  Product product;

  int counter = 1;
  double productPrice;

  //Sharpref para guardar precios y cantidades
  SharedPref _sharedPref = new SharedPref();

  //LISTA PARA GUARDAR PRODUCTOS SELECCIONADOS
  List<Product> selectedProducts = [];

  Future init(BuildContext context, Function refresh, Product product) async{
    this.context = context;
    this.refresh = refresh;
    this.product = product;
    productPrice = product.price;
    //eliminar toda la orden
    //_sharedPref.remove('order');
    // _sharedPref.remove('order');
    selectedProducts = Product.fromJsonList(await _sharedPref.read('order')).toList;

    selectedProducts.forEach((product) {
      print('Producto seleccionado: ${product.toJson()}');
    });
    refresh();

  }
  void addToBacg(){
    //consultar si el producto ya existe
    int index = selectedProducts.indexWhere((p) => p.id == product.id);

    if(index == -1){ //si es igual a menos uno no existe ese producto en la lista
      if(product.quantity == null){
        product.quantity = 1;
      }
      selectedProducts.add(product);
    }
    else{
      selectedProducts[index].quantity = counter;
    }

    _sharedPref.save('order', selectedProducts);
    Fluttertoast.showToast(msg: 'Producto agregado');
  }
  void addItem(){
    counter = counter + 1;
    productPrice = product.price * counter;
    product.quantity = counter;
    refresh();
  }

  void removeItem(){
    if(counter > 1){
      counter = counter - 1;
      productPrice = product.price * counter;
      product.quantity = counter;
      refresh();
    }
  }

  void close() {
    Navigator.pop(context);
  }



}