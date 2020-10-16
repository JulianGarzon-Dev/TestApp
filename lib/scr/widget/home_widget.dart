import 'package:flutter/material.dart';
import 'package:mocion_test/scr/pages/test_page.dart';

import 'package:flutter_signin_button/flutter_signin_button.dart';

//** Documentación del widget de la página home**//
/* Proceso que provee el widget que se ejecuta en la página home  */

Widget initPage(BuildContext context, changeTheme) {
  final _screenSize = MediaQuery.of(context).size;

  return Center(
    child: Column(
      children: <Widget>[
        SizedBox(height: _screenSize.height * 0.1),
        Text(
          ("Welcome to the\nTrivia Challengue"),
          style: TextStyle(color: Colors.white, fontSize: 22),
        ),
        SizedBox(height: _screenSize.height * 0.12),
        Text(("You will be presented"),
            style: TextStyle(color: Colors.white, fontSize: 22)),
        Text(("with 10 True or False"),
            style: TextStyle(color: Colors.white, fontSize: 22)),
        Text(("question"), style: TextStyle(color: Colors.white, fontSize: 22)),
        SizedBox(height: _screenSize.height * 0.12),
        Text(("¿Can you Score 100%?"),
            style: TextStyle(color: Colors.white, fontSize: 22)),
        SizedBox(height: _screenSize.height * 0.12),
        RaisedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => TestsPage()));
            },
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0)),
            color: Colors.white,
            textColor: Colors.black,
            padding: EdgeInsets.all(0.0),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 60.0, vertical: 10.0),
              child: Text(
                'BEGIN',
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
            )),
      ],
    ),
  );
}
