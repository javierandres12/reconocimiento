


import 'package:api_reconocimiento/ui/screen/detail_screen_bomba.dart';
import 'package:api_reconocimiento/ui/widget/button_app.dart';
import 'package:api_reconocimiento/ui/widget/button_sign.dart';
import 'package:flutter/material.dart';
import 'detail_screen.dart';
import 'login_page_barras.dart';

class PrincipalScreen extends StatefulWidget{
  String token;
  List listItem = [];
  List listID = [];

  PrincipalScreen({
    @required this.token,
    @required this.listID,
    @required this.listItem
  });

  @override
  State<StatefulWidget> createState() {
    return _PrincipalScreen();

  }
}



class _PrincipalScreen extends State<PrincipalScreen>{
  final _scaffoldkey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      key: _scaffoldkey,
        appBar: AppBar(
          backgroundColor: Colors.indigo,
          iconTheme: IconThemeData(color: Colors.white),
          title: Text('Grupo Ospedale',style:  TextStyle(fontSize: 20,fontWeight: FontWeight.w500, color: Colors.white),),
          //centerTitle: true,
        ),
        body: Container(
          margin: EdgeInsets.only(top: 15),
          child: Column(
            children: [
              ButtonSign(
                  buttonText: 'Leer monitor',
                  onPressed: (){
                    print('se presiono Machine Learning');
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> DetailScreen()));
                  },
                  color1: 0xFF285B82,
                  color2: 0xFF285B82,
                  iconData: Icons.image_aspect_ratio
              ),
              ButtonSign(
                  buttonText: 'Leer bomba Inf.',
                  onPressed: (){
                    print('se presiono Machine Learning');
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> DetailScreenBomba()));
                  },
                  color1: 0xFF285B82,
                  color2: 0xFF285B82,
                  iconData: Icons.image_aspect_ratio
              ),
            ],
          ),
        ),

        drawer:Drawer(
          child: ListView(
            children: [
              DrawerHeader(
                child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("icons/logoAms.jpg"),
                      )
                  ),
                  height: 250,
                  width: screenWidth,
                ),
              ),
              ListTile(
                title: Text('Configuración'),
                onTap: (){
                  _scaffoldkey.currentState
                      .showSnackBar(SnackBar(content: Text('Proceso en construcción')));
                },
                leading: Icon(Icons.settings),
              ),
              ListTile(
                title: Text('Cerrar Sesión'),
                onTap: (){
                  _scaffoldkey.currentState
                      .showSnackBar(SnackBar(content: Text('Saliendo de Ams')));
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LoginPageBarras()));
                },
                leading: Icon(Icons.exit_to_app),
              ),
            ],
          ),
        ),
    );
  }
  /*Future<void> _scanCode() async {
    var result = await BarcodeScanner.scan();
    setState(() {
      _scanResult = result;
    });
    if(result.format.name.isNotEmpty){
      showDialog(
          context: context,
          builder: (BuildContext context){
            return AlertDialog(
              title: Text('Lector de codigos QR y de Barras'),
              content: Container(
                width: 400,
                height: 400,
                child: Column(
                  children: [
                    Center(
                      child: Column(
                        children: [
                          Text(_scanResult.rawContent),
                          Text(_scanResult.format.toString())
                        ],
                      ),
                    )
                  ],
                ),
              ),
              actions: [
                TextButton(onPressed: (){Navigator.pop(context);}, child: Text('Cancelar')),
                TextButton(onPressed: (){Navigator.pop(context);}, child: Text('Aceptar')),
              ],

            );
          }
      );
    }
  }*/


}