import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:habitat_ft_admin/Utils/color_customer.dart';
import 'package:get/get.dart';
import 'package:habitat_ft_admin/workshops/workshops_page.dart';

class LoginPage extends StatelessWidget {


  const LoginPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
        
    return Scaffold(
      backgroundColor: ColorCustomer.blue,
      body: Center(
        child: Container(
          width: ScreenUtil().setWidth(360),
          padding: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(30), horizontal: ScreenUtil().setWidth(20)),
          decoration: BoxDecoration(
              color: ColorCustomer.ligthGrey,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 15,
                  offset: Offset(5, 5),
                )
              ]),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildLogo(),
              _buildHeader(),
              _buildLoginEmail(),
              _buildLoginButton(),
              // _buildDivider(),
              // _buildGoogleButton(),
            ],
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
      margin: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(15)),
      child: Column(children: [
        Text(
          '¡Bienvenido!',
          style: TextStyle(
            color: ColorCustomer.ligthBlue,
            fontSize: ScreenUtil().setSp(35),
            fontWeight: FontWeight.w300,
            letterSpacing: -1,
          ),
        ),
        SizedBox(height: ScreenUtil().setHeight(20)),
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
    return Container(
      child: Column(children: [
        _buildTextFormField('Correo electrónico', Icons.email),
        SizedBox(
          height: ScreenUtil().setWidth(20),
        ),
        _buildTextFormField('Contraseña', Icons.lock),
      ]),
    );
  }

  Widget _buildTextFormField(String text, IconData icon) {
    return Container(
      width: ScreenUtil().setWidth(300),
      height: ScreenUtil().setHeight(40),
      child: TextFormField(
          decoration: InputDecoration(
        suffixIcon: Icon(icon, size: ScreenUtil().setWidth(20)),
        contentPadding:
            const EdgeInsets.only(top: 16, bottom: 0, left: 15, right: 15),
        hintText: text,
        hintStyle: TextStyle(color: Colors.black38, letterSpacing: -1, fontSize: ScreenUtil().setSp(12)),
        isCollapsed: true,
        fillColor: Colors.white,
        filled: true,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: ColorCustomer.blue,
            width: 1.5,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black12, width: 1),
        ),
      )),
    );
  }

  Widget _buildLoginButton() {
    return Container(
      width: ScreenUtil().setWidth(300),
      height: ScreenUtil().setHeight(35),
      margin: EdgeInsets.only(top: ScreenUtil().setHeight(20)),
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Colors.black12,
          blurRadius: 10,
          offset: Offset(5, 5),
        )
      ]),
      child: MaterialButton(
        child: Text(
          'Iniciar sesión',
          style: TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w500,
              letterSpacing: -1),
        ),
        color: ColorCustomer.blue,
        padding: EdgeInsets.only(top: 8),
        elevation: 0,
        // height: 45,
        onPressed: () {
          Get.to(WorkshopsPage(),);
        },
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15),
      child: Row(children: [
        Container(height: 1, width: 155, color: Colors.black12),
        Container(
          width: 9,
          height: 9,
          margin: EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black12),
            color: ColorCustomer.ligthGrey,
            shape: BoxShape.circle,
          ),
        ),
        Container(height: 1, width: 155, color: Colors.black12),
      ]),
    );
  }

  Widget _buildGoogleButton() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Colors.black26,
          blurRadius: 10,
          offset: Offset(5, 5),
        )
      ]),
      child: MaterialButton(
        padding: EdgeInsets.symmetric(vertical: 7, horizontal: 10),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          Image.asset(
            'assets/icons/google_logo.png',
            width: 40,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 6),
              child: Text(
                'Continuar con Google',
                style: TextStyle(
                    color: ColorCustomer.blue,
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    letterSpacing: -1),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ]),
        color: Colors.white,
        elevation: 0,
        onPressed: () {},
      ),
    );
  }
}
