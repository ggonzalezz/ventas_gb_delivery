import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:ventas_gb_delivery/src/pages/restaurant/categories/create/restaurant_categories_create_controller.dart';
import 'package:ventas_gb_delivery/src/utils/my_colors.dart';
class RestaurantCategoriesCreatePage extends StatefulWidget {
  const RestaurantCategoriesCreatePage({Key key}) : super(key: key);

  @override
  _RestaurantCategoriesCreatePageState createState() => _RestaurantCategoriesCreatePageState();
}

class _RestaurantCategoriesCreatePageState extends State<RestaurantCategoriesCreatePage> {

  RestaurantCategoriesCreateController _con = new RestaurantCategoriesCreateController();

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
        title: Text('NUEVA CATEGORÍA'),
      ),
      body: Column(
        children: [
          SizedBox(height: 30),
          _textFieName(),
          _textFieDescription()
        ],
      ),
      bottomNavigationBar: _buttonCreate(),
    );
  }

  Widget _textFieName(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)
      ),
      child: TextField(
        controller: _con.nameController,
        decoration: InputDecoration(
            hintText: 'Nombre de la Categoría',
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(15),
            hintStyle: TextStyle(
                color: MyColors.primaryColorDark
            ),
            suffixIcon: Icon(
              Icons.category_outlined,
              color: MyColors.primaryColor,

            )
        ),
      ),
    );
  }
  Widget _textFieDescription(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
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
            hintText: 'Descripción de la categoría',
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(15),
            hintStyle: TextStyle(
                color: MyColors.primaryColorDark
            ),
            suffixIcon: Icon(
              Icons.description,
              color: MyColors.primaryColor,

            )
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
        onPressed: _con.createCategory,
        child: Text('CREAR CATEGORÍA'),
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
