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