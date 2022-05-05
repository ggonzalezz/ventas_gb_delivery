import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:ventas_gb_delivery/src/utils/my_colors.dart';
import 'client_address_create_controller.dart';

class ClientAddressCreatePage extends StatefulWidget {
  const ClientAddressCreatePage({Key key}) : super(key: key);

  @override
  _ClientAddressCreatePageState createState() => _ClientAddressCreatePageState();
}

class _ClientAddressCreatePageState extends State<ClientAddressCreatePage> {
  ClientAddressCreateController _con = ClientAddressCreateController();


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
        title: Text('Nueva direccion'),
      ),
      bottomNavigationBar: _buttonCreateAddress(),
      body: Column(
        children: [
          _textCompleteData(),
          _textFielAddress(),
          _textFielVecindario(),
          _textFielRefPoint()
        ],
      ),
    );
  }

  //textp para direccion
  Widget _textFielAddress(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: TextField(
        decoration: InputDecoration(
          labelText: 'Direccion',
          suffixIcon: Icon(
            Icons.location_on_outlined,
            color: MyColors.primaryColor,
          )
        ),
      ),
    );
  }

  //textp para direccion
  Widget _textFielVecindario(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: TextField(
        decoration: InputDecoration(
            labelText: 'Barrio o Vecindario',
            suffixIcon: Icon(
              Icons.location_city,
              color: MyColors.primaryColor,
            )
        ),
      ),
    );
  }

  //textp para direccion
  Widget _textFielRefPoint(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: TextField(
        onTap: _con.openMap,
        autofocus: false,
        focusNode: AlwaysDisableFocusNode(),
        decoration: InputDecoration(
            labelText: 'Punto de referencia',
            suffixIcon: Icon(
              Icons.map_outlined,
              color: MyColors.primaryColor,
            )
        ),
      ),
    );
  }

  //boton aceptar
  Widget _buttonCreateAddress(){
    return Container(
      height: 50,
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 30, horizontal: 50),
      child: ElevatedButton(
        onPressed: (){},
        child: Text(
            'CREAR DIRECCION'
        ),
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30)
            ),
            primary: MyColors.primaryColor
        ),
      ),
    );
  }
  //texto
  Widget _textCompleteData(){
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.symmetric(horizontal: 40, vertical: 30),
      child: Text(
        'Completa la informacion requerida',
        style: TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.bold
        ),
      ),
    );
  }

  void refresh(){
    setState(() {
    });
  }
}


class AlwaysDisableFocusNode extends FocusNode{
  @override
  bool get hasFocus => false;
}


















