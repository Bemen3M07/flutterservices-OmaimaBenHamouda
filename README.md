# Ejercicio 1 - Consumo de API de Coches

## Descripción General
Aplicación Flutter para obtener datos de coches desde una API externa. Implementa:  
- **Modelado de datos**  
- **Conexión HTTP**  
- **Manejo de JSON**  
- **Testing unitario**

---

## 🛠 Componentes Principales

### 1. Modelo `Car`
**Responsabilidad**: Representar la estructura de datos de los coches.  
- **Campos**:  
  - `id` (entero único)  
  - `year` (año de fabricación)  
  - `make` (marca)  
  - `model` (modelo)  
  - `type` (tipo de vehículo)  

- **Métodos clave**:  
  - `fromMapToCarObject()`: Constructor que mapea JSON → Objeto Dart  
  - `fromObjectToMap()`: Convierte objeto Dart → Mapa JSON  

---

### 2. Servicio `CarHttpService`
**Responsabilidad**: Gestionar la comunicación con la API.  

- **Configuración**:  
  - URL base del servidor  
  - Headers para autenticación (API key y host)  

- **Funcionalidad principal**:  
  - `getCars()`: Realiza petición GET a `/cars`, procesa respuesta y maneja errores HTTP  
![alt text](image-3.png)
---

### 3. Test Unitario
**Objetivo**: Validar el correcto funcionamiento del servicio.  

- **Pruebas implementadas**:  
  - Verifica que se obtengan 10 coches  
  - Comprueba IDs específicos en primera/última posición  
  - Detecta errores en la conexión  



![alt text](image-5.png)
![alt text](image.png)
![alt text](image-4.png)
---

## 📦 Dependencias Utilizadas
- **`http`**: Para realizar peticiones HTTP (añadida en `pubspec.yaml`)  
- **`dart:convert`**: Serialización/deserialización JSON (nativo en Dart)  
- **`flutter_test`**: Framework para testing (incluido en Flutter SDK)  

---

## ⚙ Configuración Adicional
- **Permiso de Internet**: Añadido en `AndroidManifest.xml` para permitir conexiones:  
  ```xml
  <uses-permission android:name="android.permission.INTERNET" />

# Exercici 4: Acudits

## Descripció
Aquesta aplicació mostra acudits aleatoris fent ús de l'API `https://api.sampleapis.com/jokes/goodJokes`. Cada vegada que l'usuari prem el botó, es fa una nova petició a l'API per obtenir un nou acudit.

## Estructura del projecte
El projecte està estructurat seguint el patró MVC (Model - Vista - Controlador):

```
|-- lib/
    |-- models/
        |-- joke.dart  # Definició del model Joke
    |-- controllers/
        |-- jokeService.dart  # Lògica de connexió amb l'API
    |-- views/
        |-- jokeScreen.dart  # Pantalla principal amb la UI
    |-- main.dart  # Punt d'entrada de l'aplicació
```

## Fitxers principals

### 1. Model: `joke.dart`
Definició del model `Joke`, que representa un acudit rebut de l'API.

```dart
class Joke {
  final String setup;
  final String punchline;

  Joke({required this.setup, required this.punchline});

  factory Joke.fromJson(Map<String, dynamic> json) {
    return Joke(
      setup: json['setup'],
      punchline: json['punchline'],
    );
  }
}
```

### 2. Controlador: `jokeService.dart`
Aquest servei fa la petició HTTP a l'API i retorna un acudit aleatori.

```dart
import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import '../models/joke.dart';

class JokeService {
  static Future<Joke?> fetchRandomJoke() async {
    try {
      final response = await http.get(Uri.parse('https://api.sampleapis.com/jokes/goodJokes'));
      if (response.statusCode == 200) {
        List<dynamic> jsonList = jsonDecode(response.body);
        List<Joke> jokes = jsonList.map((json) => Joke.fromJson(json)).toList();
        if (jokes.isEmpty) return null;
        return jokes[Random().nextInt(jokes.length)];
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
```

### 3. Vista: `jokeScreen.dart`
La pantalla principal de l'aplicació, on es mostra l'acudit i es permet obtenir-ne un de nou.

```dart
import 'package:flutter/material.dart';
import '../models/joke.dart';
import '../controllers/jokeService.dart';

class JokeScreen extends StatefulWidget {
  const JokeScreen({super.key});

  @override
  State<JokeScreen> createState() => _JokeScreenState();
}

class _JokeScreenState extends State<JokeScreen> {
  Joke? _currentJoke;
  bool _isLoading = false;
  String? _errorMessage;

  Future<void> _fetchNewJoke() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
    try {
      Joke? newJoke = await JokeService.fetchRandomJoke();
      setState(() {
        _currentJoke = newJoke;
        if (newJoke == null) _errorMessage = 'Failed to load joke.';
      });
    } catch (e) {
      setState(() => _errorMessage = 'An error occurred: ${e.toString()}');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Random Jokes')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (_isLoading)
                const CircularProgressIndicator()
              else if (_errorMessage != null)
                Text(_errorMessage!, style: const TextStyle(color: Colors.red))
              else if (_currentJoke != null)
                Column(
                  children: [
                    Text(_currentJoke!.setup, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Text(_currentJoke!.punchline, style: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic)),
                  ],
                )
              else
                const Text('Press the button to get a joke!'),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _isLoading ? null : _fetchNewJoke,
                child: const Text('Get New Joke'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

### 4. `main.dart`
Punt d'entrada de l'aplicació, que inicialitza `JokeScreen`.

```dart
import 'package:flutter/material.dart';
import 'views/jokeScreen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jokes App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const JokeScreen(),
    );
  }
}
![alt text](image-6.png)
```