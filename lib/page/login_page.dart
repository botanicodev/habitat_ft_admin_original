import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:habitat_ft_admin/Utils/color_customer.dart';
import 'package:habitat_ft_admin/controller/user_controller.dart';
import 'package:habitat_ft_admin/workshops/workshops_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorCustomer.blue,
      body: GetBuilder<UserController>(
        init: UserController(),
        builder: (_) => Center(
          child: Container(
            width: ScreenUtil().setWidth(354),
            height: ScreenUtil().setHeight(383),
            padding: EdgeInsets.only(top: ScreenUtil().setHeight(31)),
            decoration: BoxDecoration(
                color: ColorCustomer.grey,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 15,
                    offset: Offset(5, 5),
                  )
                ]),
            child: Obx(
              () => Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildLogo(),
                  _buildHeader(),
                  _buildLoginEmail(),
                  (_.isLoadingStream.value)
                      ? Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: CircularProgressIndicator(),
                        )
                      : _buildLoginButton()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Image.asset(
      'assets/icons/habitat_logo.png',
      width: ScreenUtil().setWidth(46),
    );
  }

  Widget _buildHeader() {
    return Container(
      margin: EdgeInsets.only(top: ScreenUtil().setHeight(15)),
      child: Column(children: [
        Text(
          '¡Bienvenido!',
          style: TextStyle(
            color: ColorCustomer.ligthBlue,
            fontSize: ScreenUtil().setSp(30),
            fontWeight: FontWeight.w100,
            letterSpacing: -1,
          ),
        ),
        SizedBox(height: ScreenUtil().setHeight(26)),
        Text(
          'Inicio de sesión',
          style: TextStyle(
            color: ColorCustomer.textGrey,
            fontSize: ScreenUtil().setSp(14),
            fontWeight: FontWeight.w600,
            letterSpacing: -1,
          ),
        ),
      ]),
    );
  }

  Widget _buildLoginEmail() {
    final loginCtrl = Get.find<UserController>();

    return Container(
      margin: EdgeInsets.only(top: ScreenUtil().setHeight(25)),
      child: Column(children: [
        _buildTextFormField(
            'Correo electrónico', loginCtrl.emailStream, Icons.email, false),
        SizedBox(
          height: ScreenUtil().setHeight(27),
        ),
        _buildTextFormField(
            'Contraseña', loginCtrl.passwordStream, Icons.lock, true),
      ]),
    );
  }

  Widget _buildTextFormField(
      String hintText, RxString dataStream, IconData icon, bool isObscureText) {
    return Container(
      width: ScreenUtil().setWidth(305),
      height: ScreenUtil().setHeight(35),
      child: TextFormField(
        obscureText: isObscureText,
        style: TextStyle(
            color: Colors.black54,
            letterSpacing: -1,
            fontSize: ScreenUtil().setSp(12)),
        decoration: InputDecoration(
          suffixIcon: Icon(icon, size: ScreenUtil().setWidth(20)),
          contentPadding: EdgeInsets.only(
            top: ScreenUtil().setHeight(10),
            bottom: ScreenUtil().setHeight(8),
            left: ScreenUtil().setWidth(15),
          ),
          hintText: hintText,
          isCollapsed: true,
          hintStyle: TextStyle(
              color: Colors.black54,
              letterSpacing: -1,
              fontSize: ScreenUtil().setSp(12)),
          fillColor: Colors.white,
          filled: true,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: ColorCustomer.blue,
              width: 1.5,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black54, width: 0),
          ),
        ),
        onChanged: (text) => dataStream.value = text,
      ),
    );
  }

  Widget _buildLoginButton() {
    final userCtrl = Get.find<UserController>();
    final emailStream = userCtrl.emailStream;
    final passwordStream = userCtrl.passwordStream;
    return Obx(
      () => Container(
        width: ScreenUtil().setWidth(305),
        height: ScreenUtil().setHeight(35),
        margin: EdgeInsets.only(top: ScreenUtil().setHeight(27)),
        child: RaisedButton(
          child: Text(
            'Iniciar sesión',
            style: TextStyle(
                color: Colors.white,
                fontSize: ScreenUtil().setSp(12),
                fontWeight: FontWeight.w500,
                letterSpacing: 0),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(3),
          ),
          color: ColorCustomer.blue,
          padding: EdgeInsets.only(top: 7),
          onPressed: (emailStream.value.isEmpty || passwordStream.value.isEmpty)
              ? null
              : () async {
                  final user = await userCtrl.signInWithEmailAndPassword(
                      emailStream.value, passwordStream.value);
                  if (user != null) {
                    Get.off(WorkshopsPage());
                  } else {
                    Get.dialog(
                      CupertinoAlertDialog(
                        content: Padding(
                          padding: const EdgeInsets.only(top: 17.0),
                          child: Text(
                            'Email y/o Contraseña no válidos',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.redAccent,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        actions: [
                          FlatButton(
                            onPressed: () => Get.back(),
                            child: Text('Aceptar',
                                style: TextStyle(
                                    color: Colors.blueAccent,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                      barrierDismissible: false,
                    );
                  }
                },
        ),
      ),
    );
  }
}
