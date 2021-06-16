
import 'dart:convert';
import 'package:api_reconocimiento/ui/screen/principal_screen.dart';
import 'package:api_reconocimiento/ui/widget/button_app.dart';
import 'package:api_reconocimiento/ui/widget/button_sign.dart';
import 'package:api_reconocimiento/ui/widget/gradient.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'login_page_barras.dart';

class LoginPageEmail extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _LoginPageEmail();
  }
}

class _LoginPageEmail extends State<LoginPageEmail> {
  //TaskDataBase db = TaskDataBase();
  int colorFront=0xFF3B4C71;
  int colorSnackbar=0xFF93D3CB;
  ScanResult scanResult;
  String idScaner;
  String valueChoose;
  List listItem = [];
  List listID = [];
  List listItemPabe = [];
  List listIDPabe = [];
  Map<String, dynamic> jsonPabellon;
  String Dominio="https://dev-ams.portubien.co";


  final _formkey = GlobalKey<FormState>();
  final _scaffoldkey = GlobalKey<ScaffoldState>();
  bool _isSend = false;
  Map<String, dynamic> jsonLogin;
  String _user;
  String _password;
  int id_clinica;

  Future _enviar() async {
    _scaffoldkey.currentState.showSnackBar(SnackBar(
      content: Container(
          height: 70,
          child: Column(
            children: [
              CircularProgressIndicator(),
              Padding(padding: EdgeInsets.all(2)),
              Text('Verificando Datos')
            ],
          )
      ),
      backgroundColor: Color(colorSnackbar),
      duration: Duration(minutes: 10),
    ));
    if (_isSend) return;
    setState(() {
      _isSend = true;
    });

    final form = _formkey.currentState;

    if (!form.validate()) {
      _scaffoldkey.currentState.hideCurrentSnackBar();
      setState(() {
        _isSend = false;
      });
      return;
    }
    form.save();

    if (_user.isNotEmpty && _password.isNotEmpty && valueChoose != null) {
      setState(() {
        id_clinica = listID[listItem.indexOf(valueChoose)];
      });

      //Uri url = Uri.https(Dominio, "api/login");
      Uri url = Uri.parse('${Dominio}/api/login');
      Map data = {
        'email': _user,
        'password': _password,
        'id_clinica': id_clinica
      };
      final response = await http.post(url,
          headers: {"Content-Type": "application/x-www-form-urlencoded"},
          body: {"json": json.encode(data)});


      //print('status: ${response.statusCode}');
      setState(() {
        jsonLogin = json.decode(response.body);
      });
      //print(response.body);
      //print(id_clinica);

      if (response.statusCode == 200) {
        _scaffoldkey.currentState.removeCurrentSnackBar();
        _scaffoldkey.currentState.showSnackBar(SnackBar(
            content: Text('Bienvenido'),
            duration: Duration(seconds: 1),
            backgroundColor: Color(colorSnackbar)));


        //Uri url1 = Uri.https(Dominio, "api/getListPabellones");
        Uri url1 = Uri.parse('${Dominio}/api/getListPabellones');
        final responsePabellon = await http.get(url1,
            headers: {
              "Content-Type": "application/x-www-form-urlencoded",
              "Authorization": 'Bearer ${jsonLogin['token']}',
            }
        );

        //print(json.decode(responsePabellon.body));
        setState(() {
          jsonPabellon= json.decode(responsePabellon.body);
        });

        print('Pabellones: ${jsonPabellon}');
        var lstPabe = new List();
        var lstItePabe = new List();
        for (int i = 0; i < jsonPabellon['data'].length; i++) {
          lstPabe.add(jsonPabellon['data'][i]['MPNomP']);
          lstItePabe.add(jsonPabellon['data'][i]['MPCodP']);
          if (lstPabe.length == jsonPabellon['data'].length) {
            listIDPabe = lstItePabe;
            listItemPabe = lstPabe;
          }
        }
        //print('ListaPabellon: ${lstPabe}');


        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    PrincipalScreen(token: 'Bearer ${jsonLogin['token']}',listID: listIDPabe,listItem: listItemPabe,)));
      } else {
        _scaffoldkey.currentState.removeCurrentSnackBar();
        _scaffoldkey.currentState.showSnackBar(SnackBar(
            content: Text(
              'Usuario no registrado, por favor verfique el usuario',
            ),
            duration: Duration(milliseconds: 1500),
            backgroundColor: Color(colorSnackbar)));
        setState(() {
          _isSend = false;
        });
      }
    } else if (valueChoose == null) {
      _scaffoldkey.currentState.removeCurrentSnackBar();
      _scaffoldkey.currentState.showSnackBar(SnackBar(
          content: Text('Por favor elige una clinica'),
          duration: Duration(seconds: 1),
          backgroundColor: Color(colorSnackbar)));
      setState(() {
        _isSend = false;
      });
    }
  }

  Future obtenerClinicas() async {

    //Uri url = Uri.https(Dominio, "api/getListClinicas");
    Uri url = Uri.parse('${Dominio}/api/getListClinicas');

    final response = await http.get(url);
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    double screenwidht = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // TODO: implement build
    return Scaffold(
      key: _scaffoldkey,
      body: Stack(
        children: [
          GradientBack(),
          Container(
            alignment: Alignment.topLeft,
            margin: EdgeInsets.only(top: 20),
            padding: EdgeInsets.only(top: 10),
            child: IconButton(icon: (Icon(Icons.arrow_back,color: Colors.white,size: 30,)), onPressed:(){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> LoginPageBarras()));
            }),
          ),
          Center(
            child: Container(
              margin: EdgeInsets.only(top: 40, left: 20, right: 20),
              width: screenwidht - 20,
              height: screenHeight - 250,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.white),
              child: FutureBuilder(
                future: obtenerClinicas(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData || snapshot.hasError) {
                    return Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.all(5),
                            width: 60,
                            height: 60,
                            child: CircularProgressIndicator(),
                          ),
                          Text('Sincronizando base de datos'),
                        ],
                      ),
                    );
                  } else {
                    var lst = new List();
                    var lstIte = new List();
                    for (int i = 0; i < snapshot.data['data'].length; i++) {
                      lst.add(snapshot.data['data'][i]['cli_nombre_clinica']);
                      lstIte.add(snapshot.data['data'][i]['cli_id']);
                      if (lst.length == snapshot.data['data'].length) {
                        listID = lstIte;
                        listItem = lst;
                      }
                    }
                    return Form(
                        key: _formkey,
                        child: Container(
                          alignment: Alignment.center,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                child: Icon(Icons.fact_check_outlined, size: 100,color: Color(colorFront),),
                                height: 100,
                                width: screenwidht-40,
                                margin: EdgeInsets.only(bottom: 5),
                              ),
                              Text(
                                'Inicio de sesión',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w900,
                                    color: Colors.black),
                              ),
                              Padding(padding: EdgeInsets.all(5)),
                              Container(
                                margin: EdgeInsets.only(left: 5,right: 5,top: 2,bottom: 2),
                                width: screenwidht - 30,
                                height: 40,
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black12,
                                      )
                                    ]),
                                child: DropdownButton(
                                    hint: Text('Seleccione la clinica: '),
                                    value: valueChoose,
                                    isExpanded: true,
                                    items: listItem.map((valueItem) {
                                      return DropdownMenuItem(
                                        value: valueItem,
                                        child: Text(valueItem),
                                      );
                                    }).toList(),
                                    onChanged: (newValue) {
                                      setState(() {
                                        valueChoose = newValue;
                                      });
                                    }),
                              ),
                              Padding(padding: EdgeInsets.all(2)),
                              Container(
                                margin: EdgeInsets.all(5),
                                width: screenwidht - 30,
                                height: 50,
                                padding: EdgeInsets.only(left: 5,right: 5),
                                decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black12,
                                      )
                                    ]),
                                child: TextFormField(
                                  keyboardType: TextInputType.name,
                                  decoration: InputDecoration(
                                    labelText: 'Usuario',
                                  ),
                                  validator: (val) {
                                    if (val.isEmpty) {
                                      return 'Por favor ingrese su usuario';
                                    } else {
                                      return null;
                                    }
                                  },
                                  onSaved: (val) {
                                    setState(() {
                                      _user = val;
                                    });
                                  },
                                ),
                              ),
                              Container(
                                margin:EdgeInsets.all(5),
                                width: screenwidht - 30,
                                height: 50,
                                padding: EdgeInsets.only(left: 5,right: 5),
                                decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black12,
                                      )
                                    ]),
                                child: TextFormField(
                                  keyboardType: TextInputType.name,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    labelText: 'Contraseña',
                                  ),
                                  validator: (val) {
                                    if (val.isEmpty) {
                                      return 'Por favor ingrese su contraseña';
                                    } else {
                                      return null;
                                    }
                                  },
                                  onSaved: (val) {
                                    setState(() {
                                      _password = val;
                                    });
                                  },
                                ),
                              ),
                              ButtonSign(
                                  buttonText: 'Ingresar con Email',
                                  onPressed: () {
                                    print('Se presiono enviar');
                                    _enviar();
                                  },
                                  color1: colorFront,
                                  color2: colorFront,
                                  iconData: Icons.email),
                              Container(
                                padding: EdgeInsets.all(5),
                                margin: EdgeInsets.all(5),
                                child: Text('Ó Ingresa con'),
                              ),
                              ButtonApp(
                                  buttonText: 'Barras',
                                  onPressed: () {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                LoginPageBarras()));
                                  },
                                  color1: colorFront,
                                  color2: colorFront,
                                  iconData: Icons.qr_code_scanner),
                            ],
                          ),
                        ));
                  }
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
