import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habitat_ft_admin/Utils/error_screen.dart';
import 'package:habitat_ft_admin/Utils/responsive_screen.dart';
import 'package:habitat_ft_admin/login/login_page.dart';
import 'package:habitat_ft_admin/workshops/workshops_page.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  runApp(Init());
}

class Init extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Habitat',
      theme: ThemeData(textTheme: GoogleFonts.spartanTextTheme()),
      initialRoute: '/',
      home: ResponsiveScreen(
        phone: ErrorPage(),
        tablet: WorkshopsPage(),
        desktop: LoginPage(),
        smart: WorkshopsPage(),
      ),
    );
  }
}
