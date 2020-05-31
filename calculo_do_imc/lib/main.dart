import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoText = "Informe seus dados";
  void _resetFields() {
    weightController.text = "";
    heightController.text = "";
    setState(() {
      _infoText = "Informe seus dados";
      _formKey = GlobalKey<FormState>();
    });
  }

  void _calculate() {
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text);
      double imc = (weight) / (height * height);
      if (imc < 18.5) {
        _infoText = "Abaixo do Peso (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 18.6 && imc <= 24.9) {
        _infoText = "Peso ideal (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 25.0 && imc <= 29.0) {
        _infoText = "Levemente Acima do peso (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 30.0 && imc <= 34.9) {
        _infoText = "Obesidade grau 1 (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 35.0 && imc <= 39.9) {
        _infoText = "Obesidade grau 2(severa) (${imc.toStringAsPrecision(3)})";
      } else if (imc > 40.0) {
        _infoText = "Obesidade grau 3(mórbida) (${imc.toStringAsPrecision(3)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Calculo do IMC"),
          centerTitle: true,
          backgroundColor: Colors.red[800],
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                _resetFields();
              },
            )
          ],
        ),
        // backgroundColor: Colors.cyan[50],
        body: Stack(
          children: <Widget>[
            Container(
              decoration: new BoxDecoration(
                  image: new DecorationImage(
                      image: new AssetImage("images/background.png"),
                      fit: BoxFit.fill)),
            ),
            SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Icon(Icons.person_outline,
                        size: 120.0, color: Colors.red[800]),
                    TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Insira seu peso!";
                        }
                      },
                      controller: weightController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Peso(kg)",
                        labelStyle: TextStyle(color: Colors.red[800]),
                      ),
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.red[800], fontSize: 20.0),
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Insira a sua altura!";
                        }
                      },
                      controller: heightController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Altura",
                        labelStyle: TextStyle(color: Colors.red[800]),
                      ),
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.red[800], fontSize: 20.0),
                    ),
                    Padding(
                        padding: EdgeInsets.only(top: 20.0),
                        child: Container(
                          height: 50.0,
                          child: RaisedButton(
                              onPressed: () {
                                if (_formKey.currentState.validate()) {
                                  _calculate();
                                }
                              },
                              color: Colors.red[800],
                              child: Text("Calcular",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 25.0))),
                        )),
                    Padding(
                      padding: EdgeInsets.only(top: 20.0),
                      child: Text(
                        _infoText,
                        textAlign: TextAlign.center,
                        style:
                            TextStyle(color: Colors.red[800], fontSize: 25.0),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
