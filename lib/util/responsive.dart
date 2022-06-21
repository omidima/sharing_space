import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

enum ScreenState { desktop, tablet, mobile }

abstract class ResponsiveState<S extends StatefulWidget> extends State<S> {
  Widget mobile(BuildContext context);
  Widget desktop(BuildContext context);
  Widget tablet(BuildContext context);
  ScreenState screenState = ScreenState.mobile;

  @protected
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 320 && screenState != ScreenState.mobile) {
          screenState = ScreenState.mobile;
          return mobile(context);
        } else if (constraints.maxWidth > 320 &&
            constraints.maxWidth <= 720 &&
            screenState != ScreenState.tablet) {
          screenState = ScreenState.tablet;
          return tablet(context);
        } else {
          screenState = ScreenState.desktop;
          return desktop(context);
        }
      },
    );
  }
}

abstract class ResponsiveWidget extends StatelessWidget {
  Widget mobile(BuildContext context);
  Widget desktop(BuildContext context);
  Widget tablet(BuildContext context);
  ScreenState screenState = ScreenState.mobile;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 320 && screenState != ScreenState.mobile) {
          screenState = ScreenState.mobile;
          return mobile(context);
        } else if (constraints.maxWidth > 320 &&
            constraints.maxWidth <= 720 &&
            screenState != ScreenState.tablet) {
          screenState = ScreenState.tablet;
          return tablet(context);
        } else {
          screenState = ScreenState.desktop;
          return desktop(context);
        }
      },
    );
  }
}
