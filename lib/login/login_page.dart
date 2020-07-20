import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:habitat_ft_admin/Utils/color_customer.dart';
import 'package:habitat_ft_admin/login/authentication_bloc.dart';
import 'package:habitat_ft_admin/repository/user_repository.dart';
import 'package:habitat_ft_admin/workshops/workshops_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthenticationBloc>(
      create: (context) => AuthenticationBloc(userRepository: UserRepository()),
      child: _Login(),
    );
  }
}

class _Login extends StatefulWidget {
  const _Login({Key key}) : super(key: key);

  @override
  __LoginState createState() => __LoginState();
}

class __LoginState extends State<_Login> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorCustomer.blue,
        body: BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            if (state is AuthenticationSuccess) {
              emailController.text = '';
              passwordController.text = '';
              Get.to(
                WorkshopsPage(),
              );
            }
          },
          child: Center(
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
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildLogo(),
                  _buildHeader(),
                  _buildLoginEmail(),
                  BlocBuilder<AuthenticationBloc, AuthenticationState>(
                      builder: (context, state) {
                    if (state is AuthenticationInProcess) {
                      return Container(
                        width: ScreenUtil().setWidth(35),
                        height: ScreenUtil().setHeight(35),
                        margin:
                            EdgeInsets.only(top: ScreenUtil().setHeight(27)),
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return _buildLoginButton(context);
                    }
                  })
                ],
              ),
            ),
          ),
        ));
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
    return Container(
      margin: EdgeInsets.only(top: ScreenUtil().setHeight(25)),
      child: Column(children: [
        _buildTextFormField(
            'Correo electrónico', Icons.email, emailController, false),
        SizedBox(
          height: ScreenUtil().setHeight(27),
        ),
        _buildTextFormField('Contraseña', Icons.lock, passwordController, true),
      ]),
    );
  }

  Widget _buildTextFormField(String text, IconData icon,
      TextEditingController controller, bool isObscureText) {
    return Container(
      width: ScreenUtil().setWidth(305),
      height: ScreenUtil().setHeight(35),
      child: TextFormField(
          controller: controller,
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
            hintText: text,
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
          )),
    );
  }

  Widget _buildLoginButton(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(305),
      height: ScreenUtil().setHeight(35),
      margin: EdgeInsets.only(top: ScreenUtil().setHeight(27)),
      child: MaterialButton(
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
        onPressed: () {
          // Get.to(WorkshopsPage());
          BlocProvider.of<AuthenticationBloc>(context).add(
              AuthenticationStarted(
                  emailController.text, passwordController.text));
        },
      ),
    );
  }
}
