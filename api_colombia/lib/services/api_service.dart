import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/env_config.dart';

class ApiService {
  // Garantiza que la URL termine limpia para evitar errores de ruta
  String get baseUrl {
    return EnvironmentConfig.apiUrl;
  }

  Future<List<dynamic>> fetchList(String endpoint) async {
    final String finalUrl = '$baseUrl/$endpoint';
    try {
      final response = await http.get(Uri.parse(finalUrl));
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Error del servidor: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Fallo de conexión: $e');
    }
  }

  Future<Map<String, dynamic>> fetchDetail(String endpoint, String id) async {
    final String finalUrl = '$baseUrl/$endpoint/$id';
    try {
      final response = await http.get(Uri.parse(finalUrl));
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Error del servidor: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Fallo al cargar el detalle: $e');
    }
  }
}
