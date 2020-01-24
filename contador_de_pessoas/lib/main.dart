import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
      title: "Marcador de tentos",
      home: Home()));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  int _nos = 0;
  int _eles = 0;
  String _nome1 = "Nós";
  String _nome2 = "Eles";
  String _infoText = "Empatado!";

  void _changenos(int add1){
    setState(() {
      _nos += add1;
      if(_nos > _eles){
        _infoText = "Dando $_nome1!";
      } else if(_nos < _eles){
        _infoText = "Dando $_nome2!";
      } else {
        _infoText = "Empatado!";
      }
      if(_nos == 12){
        _nos = 0;
        _eles = 0;
      }
      if(true){
        _nos++;
      }

    });
  }

    void _changeeles(int add){
    setState(() {
      _eles += add;
        if(_eles > _nos){
        _infoText = "Dando $_nome2 !";
      } else if(_eles < _nos){
        _infoText = "Dando $_nome1 !";
      } else {
        _infoText = "Empatado!";
      }
      if(_eles == 12){
        _nos = 0;
        _eles = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Image.asset(
          "images/baralho.jpg",
          fit: BoxFit.cover,
          height: 1000.0,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Text(
            //   "Truco",
            //   style:
            //   TextStyle(color: Colors.yellowAccent ,decoration: TextDecoration.none, fontWeight: FontWeight.bold, fontSize: 60.0),
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(right:40.0),
                    child: Text(
                      "Nós",
                      
                      style: TextStyle(fontSize: 45.0,decoration: TextDecoration.none, color: Colors.white),
                    ),
                ),
                Padding(
                  padding: EdgeInsets.only(left:40.0),
                    child: Text(
                      "Eles",
                      style: TextStyle(fontSize: 45.0,decoration: TextDecoration.none, color: Colors.white),
                    ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(right:80.0),
                    child: Text(
                      "$_nos",
                      style: TextStyle(fontSize: 65.0, decoration: TextDecoration.none, color: Colors.greenAccent),
                    ),
                ),
                Padding(
                  padding: EdgeInsets.only(left:80.0),
                    child: Text(
                      "$_eles",
                      style: TextStyle(fontSize: 65.0,decoration: TextDecoration.none, color: Colors.greenAccent),
                    ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(1.0),
                  child: FlatButton(
                    shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15.0)),
                    color: Colors.green,
                    child: Text(
                      "+1",
                      style: TextStyle(fontSize: 40.0, color: Colors.white),
                    ),
                    onPressed: () {
                      _changenos(1);
                    },
                  ),
                ),

                Padding(
                  padding: EdgeInsets.all(1.0),
                  child: FlatButton(
                    color: Colors.red,
                    shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15.0)),
                    child: Text(
                      "-1",
                      style: TextStyle(fontSize: 40.0, color: Colors.white),
                    ),
                    onPressed: () {
                      _changenos(-1);
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(1.0),
                  child: FlatButton(
                    shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15.0)),
                    color: Colors.green,
                    child: Text(
                      "+1",
                      style: TextStyle(fontSize: 40.0, color: Colors.white),
                    ),
                    onPressed: () {
                      _changeeles(1);
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(1.0),
                  child: FlatButton(
                    color: Colors.red,
                    shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15.0)),
                    child: Text(
                      "-1",
                      style: TextStyle(fontSize: 40.0, color: Colors.white),
                    ),
                    onPressed: () {
                      _changeeles(-1);
                    },
                  ),
                ),
              ],
            ),
            Padding(
            padding: EdgeInsets.only(top: 30.0),
            child: Text(
              _infoText,
              style: TextStyle(fontStyle: FontStyle.italic,decoration: TextDecoration.none, color: Colors.blue[300],fontSize: 35.0),
            ),
            ),
          // Padding(
          //   padding: EdgeInsets.only(top: 15.0),
          //   child: Text(
          //     "By: Matheus Costa",
          //     style: TextStyle(decoration: TextDecoration.none, fontStyle: FontStyle.italic,color: Colors.white,fontSize: 20.0),
          //   ),
          // ),
          ],
        )
      ],
    );
  }
}