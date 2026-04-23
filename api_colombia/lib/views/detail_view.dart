import 'package:flutter/material.dart';
import '../services/api_service.dart';

// Importamos los modelos que creaste
import '../models/president_model.dart';
import '../models/airport_model.dart';
import '../models/typical_dish_model.dart';
import '../models/department_model.dart';

class DataDetailView extends StatelessWidget {
  final String endpoint;
  final String id;
  const DataDetailView({super.key, required this.endpoint, required this.id});

  // Widget reutilizable para mostrar las filas de información
  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label: ',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.blueAccent,
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ApiService apiService = ApiService();

    return Scaffold(
      appBar: AppBar(title: const Text('Detalle de Registro')),
      body: FutureBuilder<Map<String, dynamic>>(
        future: apiService.fetchDetail(endpoint, id),
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

          final jsonItem = snapshot.data!;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // --- 1. SI ES UN PRESIDENTE ---
                if (endpoint == 'President') ...[
                  Builder(
                    builder: (context) {
                      final item = PresidentModel.fromJson(jsonItem);
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (item.image.isNotEmpty)
                            Center(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.network(
                                  item.image,
                                  height: 300,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          const SizedBox(height: 20),
                          Text(
                            '${item.name} ${item.lastName}',
                            style: const TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Divider(color: Colors.blue, thickness: 2),
                          _buildInfoRow(
                            'Partido Político',
                            item.politicalParty,
                          ),
                          _buildInfoRow(
                            'Periodo',
                            '${item.startPeriodDate} a ${item.endPeriodDate}',
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            'Biografía:',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            item.description,
                            style: const TextStyle(fontSize: 16),
                            textAlign: TextAlign.justify,
                          ),
                        ],
                      );
                    },
                  ),
                ]
                // --- 2. SI ES UN PLATO TÍPICO ---
                else if (endpoint == 'TypicalDish') ...[
                  Builder(
                    builder: (context) {
                      final item = TypicalDishModel.fromJson(jsonItem);
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (item.imageUrl.isNotEmpty)
                            Center(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.network(
                                  item.imageUrl,
                                  height: 250,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          const SizedBox(height: 20),
                          Text(
                            item.name,
                            style: const TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Divider(color: Colors.blue, thickness: 2),
                          _buildInfoRow(
                            'Ingredientes principales',
                            item.ingredients,
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            'Historia / Descripción:',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            item.description,
                            style: const TextStyle(fontSize: 16),
                            textAlign: TextAlign.justify,
                          ),
                        ],
                      );
                    },
                  ),
                ]
                // --- 3. SI ES UN DEPARTAMENTO ---
                else if (endpoint == 'Department') ...[
                  Builder(
                    builder: (context) {
                      final item = DepartmentModel.fromJson(jsonItem);
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Center(
                            child: Icon(
                              Icons.map,
                              size: 100,
                              color: Colors.green,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            item.name,
                            style: const TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const Divider(color: Colors.blue, thickness: 2),
                          _buildInfoRow(
                            'Cantidad de Municipios',
                            item.municipalities.toString(),
                          ),
                          _buildInfoRow('Superficie', '${item.surface} km²'),
                          _buildInfoRow(
                            'Población aproximada',
                            item.population.toString(),
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            'Descripción General:',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            item.description,
                            style: const TextStyle(fontSize: 16),
                            textAlign: TextAlign.justify,
                          ),
                        ],
                      );
                    },
                  ),
                ]
                // --- 4. SI ES UN AEROPUERTO ---
                else if (endpoint == 'Airport') ...[
                  Builder(
                    builder: (context) {
                      final item = AirportModel.fromJson(jsonItem);
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Center(
                            child: Icon(
                              Icons.flight_takeoff,
                              size: 100,
                              color: Colors.blueGrey,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            item.name,
                            style: const TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const Divider(color: Colors.blue, thickness: 2),
                          _buildInfoRow('Código IATA', item.iataCode),
                          _buildInfoRow('Código OACI', item.oaciCode),
                          _buildInfoRow('Tipo de Operación', item.type),
                        ],
                      );
                    },
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}
