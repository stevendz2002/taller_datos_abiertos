import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvironmentConfig {
  // Obtiene la URL base, si falla el .env, usa un valor por defecto seguro
  static String get apiUrl {
    String url =
        dotenv.env['API_BASE_URL'] ?? 'https://api-colombia.com/api/v1';
    if (url.endsWith('/')) {
      url = url.substring(0, url.length - 1);
    }
    return url;
  }
}
