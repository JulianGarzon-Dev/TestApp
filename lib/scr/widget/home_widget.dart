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
        SizedBox(height: _screenSize.height * 0.05),
        Text(
          ("Welcome to the\nTrivia Challengue"),
          style: TextStyle(color: Colors.white, fontSize: 22),
        ),
        SizedBox(height: _screenSize.height * 0.17),
        Text(("You will be presented"),
            style: TextStyle(color: Colors.white, fontSize: 22)),
        Text(("with 10 True or False"),
            style: TextStyle(color: Colors.white, fontSize: 22)),
        Text(("question"), style: TextStyle(color: Colors.white, fontSize: 22)),
        SizedBox(height: _screenSize.height * 0.17),
        Text(("¿Can you Score 100%?"),
            style: TextStyle(color: Colors.white, fontSize: 22)),
        SizedBox(height: _screenSize.height * 0.17),
        SignInButtonBuilder(
          text: "BEGIN",
          icon: Icons.note,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => TestsPage()),
            );
          },
          backgroundColor: Colors.blueGrey[700],
          width: _screenSize.width * 0.5,
          height: _screenSize.height * 0.050,
        ),
      ],
    ),
  );
}
