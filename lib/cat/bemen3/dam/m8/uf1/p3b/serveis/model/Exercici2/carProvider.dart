import 'package:flutter/foundation.dart';
import 'package:empty/cat/bemen3/dam/m8/uf1/p3b/serveis/model/Exercici1/carHttpService.dart';
import 'package:empty/cat/bemen3/dam/m8/uf1/p3b/serveis/model/Exercici1/car.dart';

class CarProvider with ChangeNotifier {
  final CarHttpService _carService = CarHttpService();
  List<Car> _cars = [];
  bool _isLoading = false;
  String _error = '';

  List<Car> get cars => _cars;
  bool get isLoading => _isLoading;
  String get error => _error;

  Future<void> fetchCars() async {
    _isLoading = true;
    notifyListeners();

    try {
      _cars = await _carService.getCars();
      _error = '';
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}