import 'package:flutter/material.dart';

class CardMonitor extends StatefulWidget {
  String result;
  List listaDatos;
  CardMonitor({
    @required this.listaDatos,
    @required this.result
  });


  @override
  State<StatefulWidget> createState() {

    return _CardMonitor();
  }

}

class _CardMonitor extends State<CardMonitor>{

  String NombreDescripcion;

  @override
  Widget build(BuildContext context) {

    if(widget.listaDatos.isEmpty){
      if(widget.result.isEmpty){
        return Container();
      }else{
        return  Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Color(0xFFFFF7E2),
                boxShadow: [
                  BoxShadow(
                      color:Colors.red,
                      blurRadius: 2
                  )
                ]
            ),
            padding: EdgeInsets.all(2),
            margin: EdgeInsets.all(3),
            child: Text(widget.result)
        );
      }

    }else{

      if(widget.listaDatos.length>=5){
        return  Container(
          width: (MediaQuery.of(context).size.width)/2,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Color(0xFFFFF7E2),
                boxShadow: [
                  BoxShadow(
                      color:Colors.red,
                      blurRadius: 2
                  )
                ]
            ),
            padding: EdgeInsets.all(5),
            margin: EdgeInsets.all(5),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 2, right: 2),
                  padding: EdgeInsets.only(bottom: 0.5),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text(
                          'FC:',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                              color: Colors.black),
                        ),
                        alignment: Alignment.topLeft,
                      ),
                      Container(
                        alignment: Alignment.topRight,
                        child: Text(
                          '${widget.listaDatos[1]}',
                          style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 15,
                              color: Colors.black),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 2, right: 2),
                  padding: EdgeInsets.only(bottom: 0.5),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text(
                          'Sp02:',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                              color: Colors.black),
                        ),
                        alignment: Alignment.topLeft,
                      ),
                      Container(
                        alignment: Alignment.topRight,
                        child: Text(
                          '${widget.listaDatos[2]}',
                          style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 15,
                              color: Colors.black),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 2, right: 2),
                  padding: EdgeInsets.only(bottom: 0.5),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text(
                          'PLS:',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                              color: Colors.black),
                        ),
                        alignment: Alignment.topLeft,
                      ),
                      Container(
                        alignment: Alignment.topRight,
                        child: Text(
                          '${widget.listaDatos[3]}',
                          style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 15,
                              color: Colors.black),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 2, right: 2),
                  padding: EdgeInsets.only(bottom: 0.5),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text(
                          'RESP:',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                              color: Colors.black),
                        ),
                        alignment: Alignment.topLeft,
                      ),
                      Container(
                        alignment: Alignment.topRight,
                        child: Text(
                          '${widget.listaDatos[4]}',
                          style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 15,
                              color: Colors.black),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            )
        );
      }else{
        return  Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Color(0xFFFFF7E2),
                boxShadow: [
                  BoxShadow(
                      color:Colors.red,
                      blurRadius: 2
                  )
                ]
            ),
            padding: EdgeInsets.all(2),
            margin: EdgeInsets.all(3),
            child: Text(widget.result)
        );
      }
      
    }

      





  }
}
