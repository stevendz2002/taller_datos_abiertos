# 🇨🇴 Explorador API Colombia - Taller de Datos Abiertos

Aplicación móvil desarrollada en Flutter que consume la [API pública de Colombia](https://api-colombia.com/), diseñada para mostrar información histórica, cultural y geográfica del país mediante una interfaz dinámica, manejo de estados y arquitectura limpia.

## 🎯 Descripción de la API y Endpoints Seleccionados

El proyecto se conecta a **API Colombia**, una plataforma de datos abiertos. El endpoint base global configurado para todas las peticiones es: 
👉 `https://api-colombia.com/api/v1/`

Para este proyecto se seleccionaron y modelaron los siguientes 4 endpoints principales:
1. **`/President`**: Listado de presidentes históricos, incluyendo periodo de gobierno y partido político.
2. **`/TypicalDish`**: Platos típicos de la gastronomía nacional, con sus ingredientes y descripción.
3. **`/Department`**: Datos geográficos, poblacionales y de superficie de los departamentos.
4. **`/Airport`**: Información de la red aeroportuaria, códigos IATA/OACI y tipo de operación.

---

## 🏗 Arquitectura y Estructura del Proyecto

El proyecto sigue una estructura de directorios escalable orientada a la separación de responsabilidades y buenas prácticas:

```text
lib/
 ┣ config/
 ┃ ┗ env_config.dart          # Configuración de variables de entorno (.env) para proteger la URL base.
 ┣ models/
 ┃ ┣ airport_model.dart       # Modelo de datos para Aeropuertos (fromJson/toJson).
 ┃ ┣ department_model.dart    # Modelo de datos para Departamentos.
 ┃ ┣ president_model.dart     # Modelo de datos para Presidentes.
 ┃ ┗ typical_dish_model.dart  # Modelo de datos para Platos Típicos.
 ┣ routes/
 ┃ ┗ app_router.dart          # Centralización de la navegación usando go_router.
 ┣ services/
 ┃ ┗ api_service.dart         # Lógica de peticiones HTTP (GET) y manejo de Status Codes.
 ┣ themes/
 ┃ ┗ app_theme.dart           # Estilos globales de la app
 ┣ views/
 ┃ ┣ dashboard_view.dart      # Pantalla inicial con la cuadrícula de navegación.
 ┃ ┣ detail_view.dart         # Pantalla de información completa del registro seleccionado.
 ┃ ┗ list_view.dart           # Pantalla que renderiza la lista de resultados de la API.
 ┣ widgets/
 ┃ ┣ dashboard_card.dart      # Tarjeta reutilizable para el menú principal.
 ┃ ┗ info_row.dart            # Componente UI para estandarizar las filas de datos en el detalle.
 ┗ main.dart                  # Punto de entrada principal, inyección de rutas y temas.