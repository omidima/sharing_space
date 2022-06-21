import 'package:flutter/material.dart';

abstract class BaseViewModel<WidgetClass extends State, StateClass> {
  WidgetClass view;
  late BuildContext context;

  BaseViewModel({required this.view}) {
    context = view.context;
  }

  onSuccess(StateClass state) {}
  onFailuer(StateClass state) {}
}
