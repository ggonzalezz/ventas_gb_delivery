import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:ventas_gb_delivery/src/pages/delibery/orders/list/delibery_orders_list_controller.dart';
import 'package:ventas_gb_delivery/src/utils/my_colors.dart';
class DeliberyOrdesLisPage extends StatefulWidget {
  const DeliberyOrdesLisPage({Key key}) : super(key: key);

  @override
  _DeliberyOrdesLisPageState createState() => _DeliberyOrdesLisPageState();
}

class _DeliberyOrdesLisPageState extends State<DeliberyOrdesLisPage> {
  DeliberyOrdersListController _con = new DeliberyOrdersListController();

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
      key: _con.key,
      appBar: AppBar(
        leading: _menuDrawer(),
      ),
      drawer: _drawer(),
      body: Center(
        child: Text('Delibery Orders List'),
      ),
    );
  }

  Widget _menuDrawer(){
    return GestureDetector(
      onTap: _con.openDrawer,
      child: Container(
        margin: EdgeInsets.only(left: 20),
        alignment: Alignment.centerLeft,
        child: Image.asset('assets/img/menu.png', width: 20, height: 20),
      ),
    );
  }

  Widget _drawer(){
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          //barra verde
          DrawerHeader(
              decoration: BoxDecoration(
                  color: MyColors.primaryColor
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${_con.user?.name ?? ''} ${_con.user?.lastname ?? ''}',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                    ),
                    maxLines: 1,

                  ),
                  Text(
                    _con.user?.email ??  '',
                    style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[200],
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic
                    ),
                    maxLines: 1,

                  ),
                  Text(
                    _con.user?.phone ??  '',
                    style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[200],
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic
                    ),
                    maxLines: 1,

                  ),
                  Container(
                    height: 60,
                    margin: EdgeInsets.only(top: 10),
                    child: FadeInImage(
                      image: _con.user?.image != null
                          ? NetworkImage(_con.user?.image)
                          : AssetImage('assets/img/noimage.png'),
                      fit: BoxFit.contain,
                      fadeInDuration: Duration(milliseconds: 50),
                      placeholder: AssetImage('assets/img/noimage.png'),
                    ),
                  )
                ],
              )
          ),
          //fin barra verde
          //inicio barra blanca

          _con.user != null ?
          _con.user.roles.length > 1 ?
          ListTile(
            onTap: _con.goToRoles,
            title: Text('Seleccionar rol'),
            trailing: Icon(Icons.person_outline),
          ) : Container() : Container(),
          ListTile(
            onTap: _con.logout,
            title: Text('Cerrar Sesión'),
            trailing: Icon(Icons.power_settings_new),
          )

          //fin barra blanca
        ],
      ) ,
    );
  }
  void refresh(){
    setState(() {}); // ctrl + s
  }
}
