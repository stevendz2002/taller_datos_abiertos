import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  // Usamos los nombres EXACTOS de la API
  final List<Map<String, dynamic>> endpoints = const [
    {'title': 'Presidentes', 'path': 'President', 'icon': Icons.person},
    {
      'title': 'Aeropuertos',
      'path': 'Airport',
      'icon': Icons.airplanemode_active,
    },
    {'title': 'Departamentos', 'path': 'Department', 'icon': Icons.map},
    {
      'title': 'Platos Típicos',
      'path': 'TypicalDish',
      'icon': Icons.restaurant,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('API Colombia')),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: endpoints.length,
        itemBuilder: (context, index) {
          final item = endpoints[index];
          return Card(
            elevation: 4,
            child: InkWell(
              onTap: () => context.push('/list/${item['path']}'),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(item['icon'], size: 40, color: Colors.blue),
                  const SizedBox(height: 10),
                  Text(
                    item['title'],
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
