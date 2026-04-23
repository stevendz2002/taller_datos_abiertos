import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'routes/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Cargamos las variables de entorno, ignoramos si falla para usar el fallback del ApiService
  try {
    await dotenv.load(fileName: ".env");
  } catch (e) {
    print('⚠️ No se encontró el archivo .env, usando URL por defecto.');
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Taller API Colombia',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.amber, // Un toque de los colores de Colombia
        useMaterial3: true,
      ),
      routerConfig: appRouter,
    );
  }
}
