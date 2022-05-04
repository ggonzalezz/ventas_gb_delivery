import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:ventas_gb_delivery/src/models/category.dart';
import 'package:ventas_gb_delivery/src/pages/restaurant/products/create/restaurant_products_create_controller.dart';
import 'package:ventas_gb_delivery/src/utils/my_colors.dart';
class RestaurantProductsCreatePage extends StatefulWidget {
  const RestaurantProductsCreatePage({Key key}) : super(key: key);

  @override
  _RestaurantProductsCreatePageState createState() => _RestaurantProductsCreatePageState();
}

class _RestaurantProductsCreatePageState extends State<RestaurantProductsCreatePage> {

  RestaurantProductsCreateController _con = new RestaurantProductsCreateController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context, refresh);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NUEVO PRODUCTO'),
      ),
      body: ListView(
        children: [
          SizedBox(height: 30),
          _textFieName(),
          _textFieDescription(),
          _textFiePrice(),
          Container(
            height: 95,
            margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _cardImage(_con.imageFile1, 1),
                _cardImage(_con.imageFile2, 2),
                _cardImage(_con.imageFile3, 3),
              ],
            ),
          ),
          _dropDownCategories(_con.categories)
        ],
      ),
      bottomNavigationBar: _buttonCreate(),
    );
  }

  Widget _textFieName(){
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)
      ),
      child: TextField(
        maxLines: 1,
        maxLength: 100,
        controller: _con.nameController,
        decoration: InputDecoration(
            hintText: 'Nombre del producto',
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(15),
            hintStyle: TextStyle(
                color: MyColors.primaryColorDark
            ),
            prefixIcon: Icon(
              Icons.category_outlined,
              color: MyColors.primaryColor,

            )
        ),
      ),
    );
  }

  Widget _dropDownCategories(List<Category> categories){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Material(
        elevation: 2.0,
        color: Colors.white,
        borderRadius:  BorderRadius.all(Radius.circular(5)),
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                children: [
                  Icon(
                    Icons.search,
                    color: MyColors.primaryColor,
                  ),
                  SizedBox(width: 15,),
                  Text(
                    'Categorías',
                     style: TextStyle(
                       color: Colors.grey,
                       fontSize: 16
                     ),
                  )
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: DropdownButton(
                  underline: Container(
                    alignment: Alignment.centerRight,
                    child: Icon(
                      Icons.arrow_drop_down_circle_outlined,
                      color: MyColors.primaryColor,
                    ),
                  ),
                  elevation: 3,
                  isExpanded: true,
                  hint: Text(
                    'Selecciona la categoría',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16
                    ),
                  ),
                  items: _dropDownItems(categories),
                  value: _con.idCategory,
                  onChanged: (option){
                    setState(() {
                      print('Categoria seleccionada $option');
                      _con.idCategory = option; //estableciendo el valor seleccionada a la variable idCategoria
                    });
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  List<DropdownMenuItem<String>> _dropDownItems(List<Category> categories){
    List<DropdownMenuItem<String>> list = [];
    categories.forEach((category) {
      list.add(DropdownMenuItem(
        child: Text(category.name),
        value: category.id,
      ));
    });
    return list;
  }
  Widget _textFieDescription(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)
      ),
      child: TextField(
        maxLines: 6,
        maxLength: 255,
        controller: _con.descriptionController,
        decoration: InputDecoration(
            hintText: 'Descripción del producto',
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(15),
            hintStyle: TextStyle(
                color: MyColors.primaryColorDark
            ),
            prefixIcon: Icon(
              Icons.description,
              color: MyColors.primaryColor,

            )
        ),
      ),
    );
  }

  Widget _textFiePrice(){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)
      ),
      child: TextField(
        controller: _con.priceController,
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
            hintText: 'Precio',
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(15),
            hintStyle: TextStyle(
                color: MyColors.primaryColorDark
            ),
            prefixIcon: Icon(
              Icons.monetization_on_outlined,
              color: MyColors.primaryColor,

            )
        ),
      ),
    );
  }

  Widget _cardImage(File imageFile, int numberFile){
    return GestureDetector(
      onTap: (){
        _con.showAlertDialog(numberFile);
      },
      child: imageFile != null
      ? Card(
        elevation: 3.0,
        child: Container(
          height: 140,
          width: MediaQuery.of(context).size.width * 0.26,
          child: Image.file(
            imageFile,
            fit: BoxFit.cover,
          ),
        ),
      )
      : Card(
        elevation: 3.0,
        child: Container(
          height: 100,
          width: MediaQuery.of(context).size.width * 0.26,
          child: Image(
            image: AssetImage('assets/img/add_image.jpg'),
          ),
        ),
      ),
    );
  }
  Widget _buttonCreate(){
    return Container(
      height: 50,
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
      child: ElevatedButton(
        onPressed: _con.createProduct,
        child: Text('CREAR PRODUCTO'),
        style: ElevatedButton.styleFrom(
            primary: MyColors.primaryColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30)
            ),
            padding: EdgeInsets.symmetric(vertical: 15)
        ),
      ),
    );
  }

  void refresh(){
    setState(() {

    });
  }
}
