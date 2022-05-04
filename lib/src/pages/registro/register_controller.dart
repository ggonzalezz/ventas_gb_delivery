import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';
import 'package:ventas_gb_delivery/src/models/response_api.dart';
import 'package:ventas_gb_delivery/src/models/user.dart';
import 'package:ventas_gb_delivery/src/provider/user_provider.dart';
import 'package:ventas_gb_delivery/src/utils/my_snackbar.dart';

class RegisterController{
  BuildContext context;
  //casteo
  TextEditingController emailController = new TextEditingController();
  TextEditingController nameController = new TextEditingController();
  TextEditingController lastNameController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController confirmPasswordController = new TextEditingController();

  UserProvider userProvider = new UserProvider();

  PickedFile pickedFile;
  File imageFile;
  Function refresh;

  //progres dialog
  ProgressDialog _progressDialog;

  //desactivar boton register
  bool isEnable = true;

  Future init(BuildContext context, Function refresh){
    this.context = context;
    this.refresh = refresh;
    userProvider.init(context);
    _progressDialog = ProgressDialog(context: context);
  }

  void register() async {
    String email = emailController.text.trim();
    String name = nameController.text.trim();
    String lastname  = lastNameController.text.trim();
    String phone = phoneController.text.trim();
    String password = passwordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();

    if(email.isEmpty || name.isEmpty || lastname.isEmpty || phone.isEmpty || password.isEmpty
        || confirmPassword.isEmpty){
      MySnackbar.show(context, 'Debes Ingresar todos los campos');
      return;
    }

    if(confirmPassword != password){
      MySnackbar.show(context, 'Las contraseñas no coinciden');
      return;
    }
    if(password.length < 6){
      MySnackbar.show(context, 'La contraseña debe de tener al menos 6 caracteres');
      return;
    }
    if(imageFile == null){
      MySnackbar.show(context, 'Seleccione una imagen');
      return;
    }
    _progressDialog.show(max: 100, msg: 'Espere un momento perrooo.....');
    isEnable = false;

    User user = new User(
      email: email,
      name: name,
      lastname: lastname,
      phone: phone,
      password: password
    );

    Stream stream = await  userProvider.createWhitImage(user, imageFile);
    stream.listen((res) {
      _progressDialog.close();

      //ResponseApi responseApi = await userProvider.create(user);
      ResponseApi responseApi = ResponseApi.fromJson(json.decode(res));
      print('Respuesta: ${responseApi?.toJson()}');
      MySnackbar.show(context, responseApi.message);

      if(responseApi.success){
        Future.delayed(Duration(seconds: 3),(){
          Navigator.pushReplacementNamed(context, 'login');
        });
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