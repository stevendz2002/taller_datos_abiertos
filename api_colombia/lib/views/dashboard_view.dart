import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../widgets/dashboard_card.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

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

          return DashboardCard(
            title: item['title'],
            icon: item['icon'],
            onTap: () => context.push('/list/${item['path']}'),
          );
        },
      ),
    );
  }
}
