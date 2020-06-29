import 'package:flutter/material.dart';

class ResponsiveScreen extends StatelessWidget {
  final phone;
  final tablet;
  final desktop;
  final smart;

  const ResponsiveScreen({this.phone, this.tablet, this.desktop, this.smart});

  @override
  Widget build(BuildContext context) {
    if (_isPhone(context)) return this.phone ?? Container();
    if (_isTablet(context)) return this.tablet ?? Container();
    if (_isDesktop(context)) return this.desktop ?? Container();
    if (_isSmart(context)) return this.smart ?? Container();
    return Container();
  }

  bool _isPhone(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width < 800;
  }

  bool _isTablet(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return (width >= 800 && width < 1200);
  }

  bool _isDesktop(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return (width >= 1200 && width < 2560);
  }

  bool _isSmart(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return (width >= 2560);
  }
}
