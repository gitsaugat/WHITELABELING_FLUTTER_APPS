import 'package:flutter/material.dart';
import 'package:primo_flutter_app/routes.dart';

void main() {
  runApp(MaterialApp(
      title: 'Primo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: Routes().routes));
}
