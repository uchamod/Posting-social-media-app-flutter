import 'package:flutter/material.dart';
import 'package:instagram_clone/util/variabals.dart';

class ResponsiveLayout extends StatefulWidget {
  final Widget webScreen;
  final Widget mobileScreen;

  const ResponsiveLayout(
      {super.key, required this.webScreen, required this.mobileScreen});

  @override
  State<ResponsiveLayout> createState() => _ResponsiveLayoutState();
}

class _ResponsiveLayoutState extends State<ResponsiveLayout> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < webScreenBreakPoint) { //check screen width
        //mobile layout
          return widget.mobileScreen;
        }
        //web layout
        return widget.webScreen;
      },
    );
  }
}
