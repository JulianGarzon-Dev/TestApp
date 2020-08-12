import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mocion_test/scr/pages/qualification_page.dart';
import 'package:mocion_test/scr/services/test_service.dart';

import 'home_page.dart';

//** Documentación de la página test, Precondiciones y Postcondiciones  **//
/* Página encargada de listar una a una las preguntas recibidas desde la API
       * Pre condiciones:
       * 1) La API debe traer datos, de lo contrario se quedara en loading circular
      
       * Pos Condiciones
       * 1) Se realizará el listado de preguntas en la misma página seteando el estado
       * 2) Las respuestas se evaluarán de acuerdo a la data de la API
       * 3) Las preguntas se evaluan a medida que se van contestando
       * 4) El resultado total de la evaluación se mostrará en una página aparte
       *
    */

class TestsPage extends StatefulWidget {
  const TestsPage({
    Key key,
  }) : super(key: key);

  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<TestsPage> {
  //variable que se encarga de setear el resultado de la evaluación
  int checkResult = 0;
  //variable que se encarga del seteo de index para el cambio de pregunta
  int indexQuestion = 0;
  //variable de resultado de respuesta en Radio Button
  int _radioResult;
  //variable para controlar los Radio Button de respuesta
  int _radioValue;

  final testsService = new TestsService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Test"),
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
        body: _questionTest());
  }

//Widget encargado de listar las preguntas
  Widget _questionTest() {
    return FutureBuilder(
      future: testsService.cargarTests(),
      builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (snapshot.hasData) {
          final results = snapshot.data;
          final questions = results.length - 1;
          final _filter2 = results[indexQuestion];

          return ListView.builder(
              itemCount: 1,
              itemBuilder: (context, indexQuestion) {
                return _crearItem(context, _filter2, questions);
              });
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

//Widget encargado de listar las posibles respuestas
  Widget _crearItem(BuildContext context, _filter2, questions) {
    final _screenSize = MediaQuery.of(context).size;
    return Column(
      children: <Widget>[
        SizedBox(
          height: _screenSize.height * 0.03,
        ),
        Text(
          (_filter2['question']),
          style: TextStyle(fontSize: 20),
        ),
        Divider(),
        ListView.builder(
            itemCount: 1,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Column(children: <Widget>[
                RadioListTile(
                  value: 0,
                  groupValue: _radioValue,
                  onChanged: _handleRadioValueChange,
                  title: Text('Verdadero'),
                ),
                RadioListTile(
                  value: 1,
                  groupValue: _radioValue,
                  onChanged: _handleRadioValueChange,
                  title: Text('Falso'),
                ),
              ]);
            }),
        Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              child: Text('Previous'),
              textColor: Colors.white,
              color: Colors.blue,
              onPressed: () {
                if (indexQuestion > 0) {
                  setState(() {
                    indexQuestion = indexQuestion - 1;
                  });
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                }
              },
            ),
            Divider(
                color: Colors.black87,
                height: 10.0,
                indent: 5.0, // Starting Space
                endIndent: 5.0 // Ending Space
                ),
            RaisedButton(
                child: Text('Next'),
                textColor: Colors.white,
                color: Colors.blue,
                onPressed: () {
                  if (questions > indexQuestion) {
                    if (_radioResult != null) {
                      setState(() {
                        checkResult =
                            questionResponseRadioOnlyAnswer(_filter2) +
                                checkResult;
                        indexQuestion = indexQuestion + 1;
                      });
                      _radioValue = null;
                      _radioResult = null;
                    } else {
                      _showAlertEmpty();
                    }
                  } else {
                    if (questionResponseRadioOnlyAnswer(_filter2) != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TestQualificationPage(
                                  checkResult: questionResponseRadioOnlyAnswer(
                                          _filter2) +
                                      checkResult,
                                )),
                      );
                    } else {
                      _showAlertEmpty();
                    }
                  }
                }),
          ],
        )
      ],
    );
  }

//Metodo encargado del control del Radio Button
  void _handleRadioValueChange(int value) {
    setState(() {
      _radioValue = value;

      switch (_radioValue) {
        case 0:
          _radioResult = 0;
          break;
        case 1:
          _radioResult = 1;
          break;
      }
    });
  }

//Función encargada de la evaluación de la respuesta seteada
  questionResponseRadioOnlyAnswer(_filter2) {
    if (_filter2['correct_answer'] == "True") {
      if (_radioResult == 0) {
        return 1;
      } else {
        return 0;
      }
    }
    if (_filter2['correct_answer'] == "False") {
      if (_radioResult == 0) {
        return 0;
      } else {
        return 1;
      }
    }
  }

//Metodo encargado de mostrar alerta en caso de no responder la pregunta
  Future<void> _showAlertEmpty() async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Reponse your Question'),
            content: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
              RaisedButton(
                padding: const EdgeInsets.all(8.0),
                textColor: Colors.white,
                color: Colors.blue,
                onPressed: () {
                  Navigator.pop(context);
                },
                child: new Text("Ok"),
              ),
            ]),
          );
        });
  }
}
