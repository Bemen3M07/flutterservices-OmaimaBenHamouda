import 'package:empty/cat/bemen3/dam/m8/uf1/p3b/serveis/model/Exercici1/car.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class CarHttpService {
  final String _serverUrl = "https://car-data.p.rapidapi.com";
  final String _headerKey =
      "6d5c68c38dmsh6c6b6c7f2b5fc40p112167jsnfde54e5cba95";
  final String _headerHost = "car-data.p.rapidapi.com";

  /*
  Obtenir la llista de cotxes
  */
  Future<List<Car>> getCars() async {
    //URL de l'endpoint: És la URL del servidor, més la URL de l'endpoint
    var uri = Uri.parse(
        "$_serverUrl/cars"); //Aquí hem de canviar el text de l'exmple per /cars

    //Fem la petició GET i esperem la resposta
    var response = await http.get(uri, headers: {
      "x-rapidapi-key": _headerKey, //Aquesta informació està a la "
      "x-rapidapi-host":
          _headerHost //Aquí hem de canviar el text de l'exmple per "x-rapidapi-host"
    });

    //Control d'errors. Si la resposta és 200, tot ha anat bé.  Si nó, llancem un error
    if (response.statusCode == 200) {
      return carsModelFromJson(response.body);
    } else {
      throw ("Error al obtenir la llista de cotxes: ${response.statusCode}");
    }
  }


}
