import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';
import 'package:ventas_gb_delivery/src/models/response_api.dart';
import 'package:ventas_gb_delivery/src/models/user.dart';
import 'package:ventas_gb_delivery/src/provider/user_provider.dart';
import 'package:ventas_gb_delivery/src/utils/my_snackbar.dart';
import 'package:ventas_gb_delivery/src/utils/shared_pref.dart';

class ClientUpdateController{
  BuildContext context;
  //casteo

  TextEditingController nameController = new TextEditingController();
  TextEditingController lastnameController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();


  UserProvider usersProvider = new UserProvider();

  PickedFile pickedFile;
  File imageFile;
  Function refresh;

  //progres dialog
  ProgressDialog _progressDialog;

  //desactivar boton register
  bool isEnable = true;
  User user;
  SharedPref _sharedPref = new SharedPref();

  Future init(BuildContext context, Function refresh) async{
    this.context = context;
    this.refresh = refresh;

    _progressDialog = ProgressDialog(context: context);
    user = User.fromJson(await _sharedPref.read('user'));

    print('TOKEN ENVIADO: ${user.session_token}');
    usersProvider.init(context, sessionUser: user);

    nameController.text = user.name;
    lastnameController.text = user.lastname;
    phoneController.text = user.phone;
    refresh();
  }

  void update() async {
    String name = nameController.text;
    String lastname = lastnameController.text;
    String phone = phoneController.text.trim();

    if (name.isEmpty || lastname.isEmpty || phone.isEmpty) {
      MySnackbar.show(context, 'Debes ingresar todos los campos');
      return;
    }

    _progressDialog.show(max: 100, msg: 'Espere un momento...');
    isEnable = false;

    User myUser = new User(
        id: user.id,
        name: name,
        lastname: lastname,
        phone: phone,
        image: user.image
    );

    Stream stream = await usersProvider.update(myUser, imageFile);
    stream.listen((res) async {
      _progressDialog.close();

      //ResponseApi responseApi = await userProvider.create(user);
      ResponseApi responseApi = ResponseApi.fromJson(json.decode(res));
      Fluttertoast.showToast(msg: responseApi.message);

      if(responseApi.success){
        user = await usersProvider.getById(myUser.id);//Obtniendo el usuario de la base de datos
        print('Usuario Obtenido: ${user.toJson()}');
        _sharedPref.save('user', user.toJson());
        Navigator.pushNamedAndRemoveUntil(context, 'client/products/list', (route) => false);
      }
      else{
        isEnable = true;
      }

    });

  }

  Future selectImage(ImageSource imageSource) async{
    pickedFile = await ImagePicker().getImage(source: imageSource);
    if(pickedFile != null){
      imageFile = File(pickedFile.path);
    }
    Navigator.pop(context);
    refresh();

  }

  void showAlertDialog(){
    Widget galleryButton = ElevatedButton(
        onPressed: () {
          selectImage(ImageSource.gallery);
        },
        child: Text('Galeria')
    );
    Widget cameraButton = ElevatedButton(
        onPressed: () {
          selectImage(ImageSource.camera);
        },
        child: Text('Camara')
    );
    AlertDialog alertDialog = AlertDialog(
      title: Text('Selecciona tu imagen'),
      actions: [
        galleryButton,
        cameraButton
      ],
    );
    showDialog(
        context: context,
        builder: (BuildContext context){
          return alertDialog;
        }
    );
  }

  void back(){
    Navigator.pop(context);
  }
}