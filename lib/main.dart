import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habitat_ft_admin/Utils/error_screen.dart';
import 'package:habitat_ft_admin/Utils/responsive_screen.dart';
import 'package:habitat_ft_admin/login/login_page.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  runApp(GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Habitat',
      theme: ThemeData(textTheme: GoogleFonts.spartanTextTheme()),
      initialRoute: '/',
      home: Init()));
}

class Init extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 1366, height: 768, allowFontScaling: true);

    return ResponsiveScreen(
      phone: ErrorPage(),
      tablet: LoginPage(),
      desktop: LoginPage(),
      smart: LoginPage(),
    );
  }
}
