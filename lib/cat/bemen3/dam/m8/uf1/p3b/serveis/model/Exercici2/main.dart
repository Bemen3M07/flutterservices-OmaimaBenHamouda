import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:empty/cat/bemen3/dam/m8/uf1/p3b/serveis/model/Exercici2/carProvider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => CarProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Eliminar el debug banner
      home: Scaffold(
        appBar: AppBar(title: const Text('Llista de Cotxes - Omaima Ben Hamouda')),
        body: Consumer<CarProvider>(
          builder: (context, provider, child) {
            if (provider.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (provider.error.isNotEmpty) {
              return Center(child: Text('Error: ${provider.error}'));
            }
            return ListView.builder(
              itemCount: provider.cars.length,
              itemBuilder: (context, index) {
                final car = provider.cars[index];
                return ListTile(
                  title: Text('${car.year} ${car.make} ${car.model}'),
                  subtitle: Text(car.type),
                );
              },
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Provider.of<CarProvider>(context, listen: false).fetchCars(),
          child: const Icon(Icons.refresh),
        ),
      ),
    );
  }
}