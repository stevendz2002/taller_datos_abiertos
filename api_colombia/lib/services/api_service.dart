import 'dart:convert';
import 'package:api_colombia/config/env_config.dart';
import 'package:http/http.dart' as http;

class ApiService {
  // Aseguramos la URL base correcta sin importar cómo esté en el .env
  String get baseUrl {
    return EnvironmentConfig.apiUrl;
  }

  // Obtener la lista completa (Ej: /President)
  Future<List<dynamic>> fetchList(String endpoint) async {
    final String finalUrl = '$baseUrl/$endpoint';
    print('🌐 CONSULTANDO API: $finalUrl'); // Para que lo veas en consola

    try {
      final response = await http.get(Uri.parse(finalUrl));

      if (response.statusCode == 200) {
        return json.decode(
          response.body,
        ); // La API devuelve una lista [ {...}, {...} ]
      } else {
        throw Exception('Error del servidor: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception(
        'Fallo de conexión: Verifica tu internet o la URL. Detalle: $e',
      );
    }
  }

  // Obtener un solo registro por ID (Ej: /President/1)
  Future<Map<String, dynamic>> fetchDetail(String endpoint, String id) async {
    final String finalUrl = '$baseUrl/$endpoint/$id';

    try {
      final response = await http.get(Uri.parse(finalUrl));
      if (response.statusCode == 200) {
        return json.decode(response.body); // Devuelve un solo objeto { ... }
      } else {
        throw Exception('Error del servidor: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Fallo al cargar el detalle: $e');
    }
  }
}
