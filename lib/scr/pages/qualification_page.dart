import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'home_page.dart';

//** Documentación de la página qualification_test, Precondiciones y Postcondiciones  **//
/* Página encargada de evaluar el total de las respuestas
       * Pre condiciones:
       * 1) Se debe recibir el total evaluado desde la página test
      
       * Pos Condiciones
       * 1) Se mostrara el resultado de la evaluacion en porcentaje
       * 2) Se cuenta con una opción para reiniciar el test
       *
    */

class TestQualificationPage extends StatefulWidget {
  final int checkResult;
  const TestQualificationPage({Key key, @required this.checkResult})
      : super(key: key);
  @override
  _TestQualificationState createState() => _TestQualificationState(checkResult);
}

class _TestQualificationState extends State<TestQualificationPage> {
  int checkResult;
  double porcentajeResult;
  _TestQualificationState(int checkResult) {
    this.checkResult = checkResult;
  } //Widget @override

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Calificación"),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(
            (FontAwesomeIcons.signOutAlt),
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          },
        ),
        body: _qualification());
  }

  _qualification() {
    porcentajeResult = (checkResult / 10) * 100;
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        textDirection: TextDirection.ltr,
        children: <Widget>[
          SizedBox(height: 30.0),
          Text(
            ('Qualification'),
            style: TextStyle(fontSize: 25),
          ),
          SizedBox(height: 50.0),
          CircularProgressIndicator(
            strokeWidth: 80,
            backgroundColor: Colors.red,
            valueColor:
                new AlwaysStoppedAnimation<Color>(Colors.lightGreenAccent),
            value: checkResult / 10,
          ),
          SizedBox(height: 50.0),
          Text(
            ('$porcentajeResult %'),
            style: TextStyle(
                fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold),
            textAlign: TextAlign.left,
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Divider(),
              RaisedButton(
                child: Text('¿Play Again?'),
                textColor: Colors.white,
                color: Colors.blue,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                },
              ),
            ],
          )
        ]);
  }
}
