

import 'package:empty/cat/bemen3/dam/m8/uf1/p3b/serveis/model/Exercici1/car.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:empty/cat/bemen3/dam/m8/uf1/p3b/serveis/model/Exercici1/carHttpService.dart';

void main() {
  group('CarsApi', () {
    test('get cars', () async {
      final carHttpService = CarHttpService();
      final cars = await carHttpService.getCars();
      expect(cars.length, 10);
      expect(cars[0].id, 9582);
      expect(cars[9].id, 9591);
    });
  });
}
