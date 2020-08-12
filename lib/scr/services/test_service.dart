import 'dart:convert';

import 'package:http/http.dart' as http;
import 'dart:async' show Future;

//** Documentación del Servicio test**//
/* Proceso encargado de obtener la data desde la API para la App */

class TestsService {
  final String _url =
      'https://opentdb.com/api.php?amount=10&difficulty=hard&type=boolean';

  Future<List<dynamic>> cargarTests() async {
    final url = '$_url';
    final resp = await http.get(url);

    final decodedData = json.decode(resp.body);
    final List results = decodedData['results'];

    //print(results[0]['category']);

    return results;
  }
}
