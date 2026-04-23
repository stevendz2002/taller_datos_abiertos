import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../services/api_service.dart';

// Importamos todos nuestros modelos
import '../models/president_model.dart';
import '../models/airport_model.dart';
import '../models/typical_dish_model.dart';
import '../models/department_model.dart';

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
              child: Text(
                'Error: ${snapshot.error}',
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          final rawData = snapshot.data!;
          if (rawData.isEmpty)
            return const Center(child: Text('No hay datos.'));

          return ListView.builder(
            itemCount: rawData.length,
            itemBuilder: (context, index) {
              final jsonItem = rawData[index];

              // Variables por defecto
              String title = 'Sin nombre';
              String subtitle = 'ID: ${jsonItem['id']}';
              Widget leadingIcon = const CircleAvatar(child: Icon(Icons.info));

              // 🌟 AQUÍ TRANSFORMAMOS EL JSON EN NUESTROS MODELOS 🌟
              if (widget.endpoint == 'President') {
                final item = PresidentModel.fromJson(jsonItem);
                title = '${item.name} ${item.lastName}';
                if (item.image.isNotEmpty) {
                  leadingIcon = CircleAvatar(
                    backgroundImage: NetworkImage(item.image),
                  );
                }
              } else if (widget.endpoint == 'Airport') {
                final item = AirportModel.fromJson(jsonItem);
                title = item.name;
                subtitle = 'Tipo: ${item.type}';
                leadingIcon = const CircleAvatar(
                  child: Icon(Icons.local_airport),
                );
              } else if (widget.endpoint == 'TypicalDish') {
                final item = TypicalDishModel.fromJson(jsonItem);
                title = item.name;
                if (item.imageUrl.isNotEmpty) {
                  leadingIcon = CircleAvatar(
                    backgroundImage: NetworkImage(item.imageUrl),
                  );
                }
              } else if (widget.endpoint == 'Department') {
                final item = DepartmentModel.fromJson(jsonItem);
                title = item.name;
                subtitle = 'Municipios: ${item.municipalities}';
                leadingIcon = const CircleAvatar(child: Icon(Icons.map));
              }

              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: ListTile(
                  leading: leadingIcon,
                  title: Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(subtitle),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () => context.push(
                    '/detail/${widget.endpoint}/${jsonItem['id']}',
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
