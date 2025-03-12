import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:empty/cat/bemen3/dam/m8/uf1/p3b/serveis/model/Exercici1/car.dart';
import 'package:empty/cat/bemen3/dam/m8/uf1/p3b/serveis/model/Exercici3/carProvider.dart';

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
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        fontFamily: 'Roboto',
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.white),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _buildAppBar(),
          _buildCarList(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Provider.of<CarProvider>(context, listen: false).getCarsData(),
        backgroundColor: Colors.indigo,
        child: const Icon(Icons.refresh, color: Colors.white),
      ),
    );
  }

  SliverAppBar _buildAppBar() {
    return SliverAppBar(
      expandedHeight: 150.0,
      flexibleSpace: const FlexibleSpaceBar(
        title: Text('Catálogo de Coches - Omaima Ben Hamouda',
            style: TextStyle(color: Colors.white, fontSize: 20)),
      ),
      backgroundColor: Colors.indigo,
      pinned: true,
    );
  }

  Widget _buildCarList() {
    return Consumer<CarProvider>(
      builder: (context, provider, _) {
        if (provider.isLoading) {
          return const SliverFillRemaining(
            child: Center(child: CircularProgressIndicator(color: Colors.indigo)),
          );
        }

        if (provider.error.isNotEmpty) {
          return SliverFillRemaining(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, color: Colors.red, size: 50),
                  const SizedBox(height: 20),
                  Text(provider.error,
                      style: const TextStyle(fontSize: 18, color: Colors.red)),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.refresh),
                    label: const Text('Reintentar'),
                    onPressed: () => provider.getCarsData(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigo,
                      foregroundColor: Colors.white,
                    ),
                  )
                ],
              ),
            ),
          );
        }

        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final car = provider.cars[index];
              return _buildCarCard(car);
            },
            childCount: provider.cars.length,
          ),
        );
      },
    );
  }

  Widget _buildCarCard(Car car) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.indigo.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.directions_car, color: Colors.indigo),
        ),
        title: Text(
          '${car.year} ${car.make} ${car.model}',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.indigo,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 5),
            Text(
              car.type.toUpperCase(),
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                const Icon(Icons.confirmation_number, size: 16, color: Colors.grey),
                const SizedBox(width: 5),
                Text(
                  'ID: ${car.id}',
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
      ),
    );
  }
}
