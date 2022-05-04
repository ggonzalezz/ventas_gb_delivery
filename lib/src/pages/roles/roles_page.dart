import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:ventas_gb_delivery/src/models/rol.dart';
import 'package:ventas_gb_delivery/src/pages/roles/roles_controller.dart';
class RolesPage extends StatefulWidget {
  const RolesPage({Key key}) : super(key: key);

  @override
  _RolesPageState createState() => _RolesPageState();
}

class _RolesPageState extends State<RolesPage> {
  RolesController _con =  new RolesController();

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
        title: Text('Seleccione un rol'),
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.14),
        child: ListView(
          children: _con.user !=null ? _con.user.roles.map((Rol rol){
            return _carRol(rol);
          }).toList() : []
        ),
      )
    );
  }

  Widget _carRol(Rol rol){

    return GestureDetector(
      onTap: () {
        _con.goToPage(rol.route);
      },
      child: Column(
        children: [
          Container(
            height: 100,
              child: FadeInImage(
                image: rol.image!= null ? NetworkImage(rol.image) : AssetImage('assets/img/noimage.png'),
                fit: BoxFit.contain,
                fadeInDuration: Duration(milliseconds: 50),
                placeholder: AssetImage('assets/img/noimage.png'),
              ),
          ),
          SizedBox(height: 15,),
          Text(
            rol.name ?? '',
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
              fontWeight: FontWeight.bold
            ),
          ),
          SizedBox(height: 25,),
        ],
      ),
    );

  }

  void refresh(){
    setState(() {
    });
  }









}
