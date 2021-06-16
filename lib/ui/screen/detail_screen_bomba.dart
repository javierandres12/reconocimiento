
import 'dart:io';
import 'package:api_reconocimiento/ui/widget/card_bomba.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';



class DetailScreenBomba extends StatefulWidget{



  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _DetailScreenBomba();
  }
}

class _DetailScreenBomba extends State<DetailScreenBomba>{
  List listaDatos=[];
  String selectedItem= "";
  var result = "";
  File pickedImage;
  var imageFile;
  bool isImageLoaded = false;
  int colorAppbar=0xFF5574E4;
  int colorFront=0xFF3B4C71;//0xFF93D3CB


  getImageFromGallery() async {
    var tempStore = await ImagePicker().getImage(source: ImageSource.gallery);
    setState(() {
      pickedImage=File(tempStore.path);
      isImageLoaded=true;
    });
  }

  getImageFromCamera() async {
    var tempStore = await ImagePicker().getImage(source: ImageSource.camera);
    setState(() {
      pickedImage=File(tempStore.path);
      isImageLoaded=true;
    });

  }

  readTextFromAnImage()  async{

    FirebaseVisionImage myImage = FirebaseVisionImage.fromFile(pickedImage);
    TextRecognizer recognizeText = FirebaseVision.instance.textRecognizer();
    TextRecognizer cloudTextRecognizer = FirebaseVision.instance.cloudTextRecognizer();
    VisionText readText = await recognizeText.processImage(myImage);
    //VisionText readText = await  cloudTextRecognizer.processImage(myImage);

    List listaDa=new List();

    String text = readText.text;
    for (TextBlock block in readText.blocks) {
      final Rect boundingBox = block.boundingBox;
      final List<Offset> cornerPoints = block.cornerPoints;
      final String text = block.text;
      final List<RecognizedLanguage> languages = block.recognizedLanguages;

      for (TextLine line in block.lines) {
        // Same getters as TextBlock
        for (TextElement element in line.elements) {
          // Same getters as TextBlock
          print(element.text);
          setState(() {
            result = result +'\n '+ element.text;
          });

        }
      }

    }


  }

  final _scaffoldkey = GlobalKey<ScaffoldState>();
  // variable para el key que permite acceder al formulario actual del codigo
  final _formkey =  GlobalKey<FormState>();
  // creamos las variables para guardar los datos

  int color1= 0xFF2EBFF7;


  @override
  Widget build(BuildContext context) {
    selectedItem = ModalRoute.of(context).settings.arguments.toString();
    //variables para el largo y ancho de la pantalla
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidht = MediaQuery.of(context).size.width;


    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(colorFront),
        title: Text('Captura Bomba Inf.',style: TextStyle(color: Colors.white),),
        centerTitle: true,
        leading:  IconButton(icon: Icon(Icons.arrow_back,color: Colors.white,), onPressed: (){
          Navigator.pop(context);
        }),
        actions: [
          IconButton(
              icon: Icon(Icons.image_search , color: Colors.white,),
              onPressed: (){
                getImageFromGallery();
              }
          ),
          IconButton(
              icon: Icon(Icons.add_a_photo , color: Colors.white,),
              onPressed: (){
                getImageFromCamera();
              }
          )
        ],
      ),
      body: ListView(
        children: [
          SizedBox(height: 100),
          isImageLoaded ? Center(
            child: Container(
              height: screenHeight/1.8,
              width: screenWidht,
              decoration: BoxDecoration(
                  image: DecorationImage(
                    image: FileImage(pickedImage),

                  )
              ),
            ),
          ) : Container(),
          Container(
              margin: EdgeInsets.only(left: 20,right: 20,bottom: 20),
              padding: EdgeInsets.only(left: 20,right: 20,bottom: 20),
              alignment: Alignment.center,
              child: CardBomba(
                listaDatos: listaDatos,
                result: result,
            )
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Color(colorFront),
          child: Icon(Icons.check,color: Colors.white,),
          onPressed: readTextFromAnImage
      ),

    );




  }
}

