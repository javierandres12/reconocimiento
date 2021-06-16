import 'package:api_reconocimiento/ui/screen/login_page_barras.dart';
import 'package:api_reconocimiento/ui/screen/principal_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(ReconocimientoApp());
}

class ReconocimientoApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
        title: 'Api Reconocimiento',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          primaryColor: Color(0xFF2EBFF7),
          accentColor: Colors.blueAccent,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: LoginPageBarras()
    );
  }
}