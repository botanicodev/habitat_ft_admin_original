import 'package:flutter/material.dart';
import 'package:habitat_ft_admin/Utils/error_screen.dart';
import 'package:habitat_ft_admin/Utils/responsive_screen.dart';

import 'login/login_screen.dart';

void main() => runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Habitat',
        home: ResponsiveScreen(
          phone: ErrorPage(),
          tablet: LoginPage(),
          desktop: LoginPage(),
          smart: LoginPage(),
        ),
      ),
    );
