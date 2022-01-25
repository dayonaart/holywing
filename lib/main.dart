import 'package:app/contoller/main_controller.dart';
import 'package:app/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [ChangeNotifierProvider<MainController>(create: (_) => MainController())],
    child: GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    ),
  ));
}
