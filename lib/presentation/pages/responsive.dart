import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget mobile;
  final Widget tablet;
  final Widget desktop;

  const ResponsiveLayout(
      {required this.mobile,
      required this.tablet,
      required this.desktop,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth >= 1024) {
      return Center(child: desktop);
    } else if (screenWidth >= 600) {
      return Center(child: tablet);
    } else {
      return Center(child: mobile);
    }
  }
}
