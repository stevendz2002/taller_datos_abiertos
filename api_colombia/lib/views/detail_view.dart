import 'package:flutter/material.dart';
import '../services/api_service.dart';

class DataDetailView extends StatelessWidget {
  final String endpoint;
  final String id;
  const DataDetailView({super.key, required this.endpoint, required this.id});

  @override
  Widget build(BuildContext context) {
    final ApiService apiService = ApiService();

    return Scaffold(
      appBar: AppBar(title: const Text('Información Completa')),
      body: FutureBuilder<Map<String, dynamic>>(
        future: apiService.fetchDetail(endpoint, id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final item = snapshot.data!;
          return ListView(
            padding: const EdgeInsets.all(16.0),
            children: item.entries.map((entry) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: RichText(
                  text: TextSpan(
                    style: const TextStyle(color: Colors.black, fontSize: 16),
                    children: [
                      TextSpan(
                        text: '${entry.key}: ',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                      TextSpan(text: '${entry.value}'),
                    ],
                  ),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
