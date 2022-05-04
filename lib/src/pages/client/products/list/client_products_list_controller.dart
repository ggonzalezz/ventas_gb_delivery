import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:ventas_gb_delivery/src/models/category.dart';
import 'package:ventas_gb_delivery/src/models/product.dart';
import 'package:ventas_gb_delivery/src/models/user.dart';
import 'package:ventas_gb_delivery/src/pages/client/products/detail/client_products_detail_controller.dart';
import 'package:ventas_gb_delivery/src/pages/client/products/detail/client_products_detail_page.dart';
import 'package:ventas_gb_delivery/src/provider/categories_provider.dart';
import 'package:ventas_gb_delivery/src/provider/products_provider.dart';
import 'package:ventas_gb_delivery/src/utils/shared_pref.dart';

class ClientProductsListController {

  BuildContext context;

  SharedPref _sharedPref = new SharedPref();
  GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();
  Function refresh;
  //datos del usuario en el menu
  User user;
  CategoriesProvider _categoriesProvider = new CategoriesProvider();
  ProductsProvider _productsProvider = new ProductsProvider();
  //lista vacia para categoriass
  List<Category> categories = [];
  //lista vacia para productos
  //List<Product> products = [];

  Future init(BuildContext context, Function refresh) async{
    this.context = context;
    this.refresh = refresh;
    //parse el nombre del usuario para mostrarlo en la page
    user = User.fromJson(await _sharedPref.read('user'));
    _categoriesProvider.init(context, user);
    _productsProvider.init(context, user);
    getCategories();
    refresh();
  }
  //traer los productos por categoria
  Future<List<Product>> getProducts(String idCategory) async{
    return await _productsProvider.getByCategory(idCategory);
  }


  //Traer las categorias
  void getCategories() async{
    categories = await _categoriesProvider.getAll();
    refresh();
  }
  //abrir el modal

  void openBottonSheet(Product product){
    showMaterialModalBottomSheet(
        context: context,
        builder: (context) => ClientProductsDetailPage(product: product)
    );
  }



  void logout(){
    _sharedPref.logout(context, user.id);
  }

  void openDrawer(){
    key.currentState.openDrawer();
  }

  void goToUpdatePage(){
    Navigator.pushNamed(context, 'client/update');
  }
  //metodo al precionar la bolsa
  void goToOrderCreatePage(){
    Navigator.pushNamed(context, 'client/orders/create');
  }

  void goToRoles(){
    Navigator.pushNamedAndRemoveUntil(context, 'roles', (route) => false);
  }
}
