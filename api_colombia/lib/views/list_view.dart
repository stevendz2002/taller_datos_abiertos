import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../services/api_service.dart';

class DataListView extends StatefulWidget {
  final String endpoint;
  const DataListView({super.key, required this.endpoint});

  @override
  State<DataListView> createState() => _DataListViewState();
}

class _DataListViewState extends State<DataListView> {
  final ApiService _apiService = ApiService();
  late Future<List<dynamic>> _futureData;

  @override
  void initState() {
    super.initState();
    // Dispara la petición al entrar a la pantalla
    _futureData = _apiService.fetchList(widget.endpoint);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Listado: ${widget.endpoint}')),
      body: FutureBuilder<List<dynamic>>(
        future: _futureData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Error brutal: ${snapshot.error}',
                  style: const TextStyle(color: Colors.red, fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }

          final data = snapshot.data!;
          if (data.isEmpty) {
            return const Center(child: Text('La API no devolvió datos.'));
          }

          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              final item = data[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: ListTile(
                  title: Text(
                    item['name']?.toString() ?? 'Sin nombre asignado',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text('ID en base de datos: ${item['id']}'),
                  trailing: const Icon(Icons.arrow_forward),
                  onTap: () {
                    context.push('/detail/${widget.endpoint}/${item['id']}');
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
