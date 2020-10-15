import 'package:flutter/material.dart';

import 'package:mocion_test/scr/pages/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(
    BuildContext context,
  ) {
    return MaterialApp(
        theme: ThemeData.light(),
        title: 'Test App',
        debugShowCheckedModeBanner: false,
        initialRoute: 'home',
        routes: {
          'home': (BuildContext context) => HomePage(),
        });
  }
}
