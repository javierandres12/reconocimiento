import 'package:flutter/material.dart';

class GradientBack extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    double screenHeigth = MediaQuery.of(context).size.height;
    // TODO: implement build
    return Container(
      alignment: Alignment(-0.9, -0.6),
      height: screenHeigth,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF5574E4),
            Color(0xFF151F43)
          ],
          begin: FractionalOffset(0.3, 0.0),
          end: FractionalOffset(1.0, 0.8),
          stops: [0.3,0.6]
        )
      ),
    );
  }
}