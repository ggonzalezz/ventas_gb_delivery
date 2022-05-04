import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:ventas_gb_delivery/src/pages/client/update/client_update_controller.dart';
import 'package:ventas_gb_delivery/src/pages/registro/register_controller.dart';
import 'package:ventas_gb_delivery/src/utils/my_colors.dart';

class ClientUpdatePage extends StatefulWidget {
  const ClientUpdatePage({Key key}) : super(key: key);

  @override
  _ClientUpdatePageState createState() => _ClientUpdatePageState();
}

class _ClientUpdatePageState extends State<ClientUpdatePage> {
  ClientUpdateController _con = new ClientUpdateController();

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
          title: Text('Editar pefil'),
        ),
        body: Container(
            width: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 30),
                  _imageUser(),
                  SizedBox(height: 20),
                  _textFielName(),
                  _textFielLastName(),
                  _textFiePhone(),
                  SizedBox(height: 20,)
                ],
              ),
            ),
        ),
        bottomNavigationBar:  _buttonRegister(),
    );
  }

  Widget _imageUser(){
    return GestureDetector(
      onTap: _con.showAlertDialog,
      child: CircleAvatar(
        backgroundImage: _con.imageFile != null
            ? FileImage(_con.imageFile)
            : _con.user?.image != null
            ? NetworkImage(_con.user?.image)
            : AssetImage('assets/img/user_profile.png'),
        radius: 50,
        backgroundColor: Colors.grey[200],
      ),
    );
  }
//regresar
  Widget _iconBack(){
    return IconButton(
      onPressed: _con.back,
      icon: Icon(Icons.arrow_back_ios, color:Colors.white),
    );
  }

  Widget _textRegister(){
    return Text(
      'REGISTRO',
      style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 20,
          fontFamily: 'montserratBold'
      ),
    );
  }

  Widget _buttonRegister(){
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
      child: ElevatedButton(
        onPressed: _con.isEnable ? _con.update : null,
        child: Text('ACTUALIZAR PEFIL'),
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


  Widget _textFielName(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)
      ),
      child: TextField(
        controller: _con.nameController,
        keyboardType: TextInputType.name,
        decoration: InputDecoration(
            hintText: 'Nombres',
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(15),
            hintStyle: TextStyle(
                color: MyColors.primaryColorDark
            ),
            prefixIcon: Icon(
              Icons.person,
              color: MyColors.primaryColor,

            )
        ),
      ),
    );
  }
  Widget _textFielLastName(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)
      ),
      child: TextField(
        controller: _con.lastnameController,
        keyboardType: TextInputType.name,
        decoration: InputDecoration(
            hintText: 'Apellidos',
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(15),
            hintStyle: TextStyle(
                color: MyColors.primaryColorDark
            ),
            prefixIcon: Icon(
              Icons.person_outline,
              color: MyColors.primaryColor,

            )
        ),
      ),
    );
  }
  Widget _textFiePhone(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)
      ),
      child: TextField(
        controller: _con.phoneController,
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
            hintText: 'Teléfono',
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(15),
            hintStyle: TextStyle(
                color: MyColors.primaryColorDark
            ),
            prefixIcon: Icon(
              Icons.phone_android,
              color: MyColors.primaryColor,

            )
        ),
      ),
    );
  }
 
  Widget _circleRegister(){
    return Container(
      width: 240,
      height: 230,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: MyColors.primaryColor,
      ),
    );
  }

  void refresh(){
    setState(() {
    });
  }
}
