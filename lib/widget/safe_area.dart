import 'package:app/colors/colors.dart';
import 'package:flutter/material.dart';

SafeArea SAFE_AREA(Widget child) {
  return SafeArea(
      child: Scaffold(
        body: child,
        backgroundColor: backgroundColor,
      ),
      top: true);
}
