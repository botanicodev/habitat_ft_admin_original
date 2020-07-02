import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habitat_ft_admin/Utils/error_screen.dart';
import 'package:habitat_ft_admin/Utils/responsive_screen.dart';
import 'package:habitat_ft_admin/workshops/workshops_page.dart';

import 'login/login_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Habitat',
      theme: ThemeData(textTheme: GoogleFonts.spartanTextTheme()),
      home: ResponsiveScreen(
        phone: ErrorPage(),
        tablet: WorkshopsPage(),
        desktop: WorkshopsPage(),
        smart: WorkshopsPage(),
      ),
    ),
  );
}
