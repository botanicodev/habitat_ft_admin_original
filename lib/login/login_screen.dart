import 'package:flutter/material.dart';
import 'package:habitat_ft_admin/Utils/color_customer.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorCustomer.blue,
      body: Center(
        child: Container(
          width: 400,
          padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
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
              _buildDivider(),
              _buildGoogleButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Container(width: 60, height: 60, child: FlutterLogo());
  }

  Widget _buildHeader() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15),
      child: Column(children: [
        Text(
          '¡Bienvenido!',
          style: GoogleFonts.spartan(
            color: ColorCustomer.ligthBlue,
            fontSize: 35,
            fontWeight: FontWeight.w300,
            letterSpacing: -1,
          ),
        ),
        SizedBox(height: 20),
        Text(
          'Inicio de Sesión',
          style: GoogleFonts.spartan(
            color: ColorCustomer.textGrey,
            fontSize: 16,
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
        _buildTextFormField('Correo Electrónico', Icons.email),
        SizedBox(
          height: 20,
        ),
        _buildTextFormField('Contraseña', Icons.lock),
      ]),
    );
  }

  Widget _buildTextFormField(String text, IconData icon) {
    return TextFormField(
        decoration: InputDecoration(
      suffixIcon: Icon(icon, size: 20),
      contentPadding:
          const EdgeInsets.only(top: 16, bottom: 0, left: 15, right: 15),
      hintText: text,
      hintStyle: GoogleFonts.spartan(color: Colors.black38, letterSpacing: -1),
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
    ));
  }

  Widget _buildLoginButton() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 30),
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Colors.black12,
          blurRadius: 10,
          offset: Offset(5, 5),
        )
      ]),
      child: MaterialButton(
        child: Text(
          'Iniciar Sesión',
          style: GoogleFonts.spartan(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w500,
              letterSpacing: -1),
        ),
        color: ColorCustomer.blue,
        padding: EdgeInsets.only(top: 8),
        minWidth: 600,
        elevation: 0,
        height: 45,
        onPressed: () {},
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
            'assets/images/google_logo.png',
            width: 40,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 6),
              child: Text(
                'Continuar con Google',
                style: GoogleFonts.spartan(
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
