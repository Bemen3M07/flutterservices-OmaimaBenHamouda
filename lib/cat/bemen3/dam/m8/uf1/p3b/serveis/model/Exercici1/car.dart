import 'dart:convert'; // Add this import for JSON decoding
import 'package:http/http.dart' as http;

final String URL = "https://car-data.p.rapidapi.com/cars"; // Use a String for URL

// Funció per obtenir una llista d'objectes de tipus CarsModel a partir d'un string json
List<Car> carsModelFromJson(String str) => List<Car>.from(
    json.decode(str).map((x) => Car.fromMapToCarObject(x)));
    

//Funció per obtenir un string json a partir d'una llista d'objectes de tipus CarsModel
String carsModelToJson(List<Car> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.fromObjectToMap())));

class Car {
  final int id;
  final int year;
  final String make;
  final String model;
  final String type;

  Car({
    required this.id,
    required this.year,
    required this.make,
    required this.model,
    required this.type,
  });

 factory Car.fromMapToCarObject(Map<String, dynamic> json) => Car(
        id: json["id"],
        year: json["year"],
        make: json["make"],
        model: json["model"],
        type: json["type"],
      );

  // Mètode per convertir un objecte de tipus CarsModel a un mapa d'objectes
  Map<String, dynamic> fromObjectToMap() => {
        "id": id,
        "year": year,
        "make": make,
        "model": model,
        "type": type,
      };

}

