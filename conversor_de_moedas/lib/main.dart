import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

const request = "https://api.hgbrasil.com/finance?format=json&key=<32025868>";

void main() async {
  runApp(MaterialApp(
    home: Home(),
    theme: ThemeData(
        hintColor: Colors.amber,
        primaryColor: Colors.white,
        inputDecorationTheme: InputDecorationTheme(
          enabledBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          focusedBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.amber)),
          hintStyle: TextStyle(color: Colors.amber),
        )),
  ));
}

Future<Map> getData() async {
  http.Response response = await http.get(request);
  return json.decode(response.body);
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final realController = TextEditingController();
  final dolarController = TextEditingController();
  final euroController = TextEditingController();
  final libraController = TextEditingController();
  final pesoController = TextEditingController();
  final bitcoinController = TextEditingController();

  double dolar;
  double euro;
  double libra;
  double bitcoin;
  double peso;
  void _resetar() {
    realController.text = "";
    dolarController.text = "";
    euroController.text = "";
    libraController.text = "";
    pesoController.text = "";
    bitcoinController.text = "";
  }

  void _realConvertido(String text) {
    if (text.isEmpty) {
      _resetar();
      return;
    }
    double real = double.parse(text);
    dolarController.text = (real / dolar).toStringAsFixed(2);
    euroController.text = (real / euro).toStringAsFixed(2);
    libraController.text = (real / libra).toStringAsFixed(2);
    bitcoinController.text = (real / bitcoin).toStringAsFixed(5);
    pesoController.text = (real / peso).toStringAsFixed(2);
  }

  void _dolarConvertido(String text) {
    if (text.isEmpty) {
      _resetar();
      return;
    }
    double dolar = double.parse(text);
    realController.text = (dolar * this.dolar).toStringAsFixed(2);
    euroController.text = (dolar * this.dolar / euro).toStringAsFixed(2);
    libraController.text = (dolar * this.dolar / libra).toStringAsFixed(2);
    bitcoinController.text = (dolar * this.dolar / bitcoin).toStringAsFixed(5);
    pesoController.text = (dolar / peso).toStringAsFixed(2);
  }

  void _euroConvertido(String text) {
    if (text.isEmpty) {
      _resetar();
      return;
    }
    double euro = double.parse(text);
    realController.text = (euro * this.euro).toStringAsFixed(2);
    dolarController.text = (euro * this.euro / dolar).toStringAsFixed(2);
    libraController.text = (euro * this.euro / libra).toStringAsFixed(2);
    bitcoinController.text = (euro * this.euro / bitcoin).toStringAsFixed(5);
    pesoController.text = (euro / peso).toStringAsFixed(2);
  }

  void _libraConvertido(String text) {
    double libra = double.parse(text);
    realController.text = (libra * this.libra).toStringAsFixed(2);
    dolarController.text = (libra * this.libra / dolar).toStringAsFixed(2);
    euroController.text = (libra * this.libra / euro).toStringAsFixed(2);
    bitcoinController.text = (libra * this.libra / bitcoin).toStringAsFixed(5);
    pesoController.text = (libra / peso).toStringAsFixed(2);
  }

  void _pesoConvertido(String text) {
    double peso = double.parse(text);
    realController.text = (peso * this.peso).toStringAsFixed(2);
    dolarController.text = (peso * this.peso / dolar).toStringAsFixed(2);
    euroController.text = (peso * this.peso / euro).toStringAsFixed(2);
    libraController.text = (peso * this.peso / libra).toStringAsFixed(2);
    bitcoinController.text = (peso * this.peso / bitcoin).toStringAsFixed(5);
  }

  void _bitConvertido(String text) {
    double bitcoin = double.parse(text);
    realController.text = (bitcoin * this.bitcoin).toStringAsFixed(2);
    dolarController.text = (bitcoin * this.bitcoin / dolar).toStringAsFixed(2);
    euroController.text = (bitcoin * this.bitcoin / euro).toStringAsFixed(2);
    libraController.text = (bitcoin * this.bitcoin / libra).toStringAsFixed(2);
    pesoController.text = (bitcoin / peso).toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.amber,
        title: Text("\$ Conversor de moedas \$"),
      ),
      body: FutureBuilder<Map>(
          future: getData(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                dolar = snapshot.data["results"]["currencies"]["USD"]["buy"];
                euro = snapshot.data["results"]["currencies"]["EUR"]["buy"];
                libra = snapshot.data["results"]["currencies"]["GBP"]["buy"];
                bitcoin = snapshot.data["results"]["currencies"]["BTC"]["buy"];
                peso = snapshot.data["results"]["currencies"]["ARS"]["buy"];

                return SingleChildScrollView(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Icon(Icons.monetization_on,
                              size: 150.0, color: Colors.amber),
                          buildTextField(
                              "Reais", "R\$", realController, _realConvertido),
                          Divider(),
                          buildTextField("Dólares", "US\$", dolarController,
                              _dolarConvertido),
                          Divider(),
                          buildTextField(
                              "Euros", "€\$", euroController, _euroConvertido),
                          Divider(),
                          buildTextField("Libra", "£\$", libraController,
                              _libraConvertido),
                          Divider(),
                          buildTextField("Peso Argentino", "A\$",
                              pesoController, _pesoConvertido),
                          Divider(),
                          buildTextField("Bitcoin", "₿", bitcoinController,
                              _bitConvertido),
                        ]));
              default:
                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      "Ocorreu algum erro verifique a sua conexão",
                      style: TextStyle(color: Colors.red, fontSize: 25.0),
                    ),
                  );
                } else {
                  return Center(
                    child: Text(
                      "Carregando...",
                      style: TextStyle(color: Colors.amber, fontSize: 25.0),
                    ),
                  );
                }
            }
          }),
    );
  }
}

Widget buildTextField(String label, String prefix,
    TextEditingController moedaControler, Function inputando) {
  return TextField(
    controller: moedaControler,
    keyboardType: TextInputType.numberWithOptions(decimal: true),
    decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.amber),
        border: OutlineInputBorder(),
        prefixText: prefix),
    style: TextStyle(fontSize: 25.0, color: Colors.amber),
    onChanged: inputando,
  );
}
