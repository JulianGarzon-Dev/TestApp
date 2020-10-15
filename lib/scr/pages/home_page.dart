import 'package:flutter/material.dart';
import 'package:mocion_test/scr/widget/home_widget.dart';

//** Documentación de la página home**//
/* Página encargada de de mostrar la página de inicio de la App  */

class HomePage extends StatefulWidget {
  //const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool changeTheme = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Test Challegue"),
        ),
        backgroundColor: Color.fromRGBO(50, 50, 50, 1.0),
        body: initPage(context, changeTheme));
  }
}
