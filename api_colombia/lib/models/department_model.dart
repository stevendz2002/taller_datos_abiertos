class DepartmentModel {
  final int id;
  final String name;
  final String description;
  final int municipalities;
  final int surface;
  final int population;

  DepartmentModel({
    required this.id,
    required this.name,
    required this.description,
    required this.municipalities,
    required this.surface,
    required this.population,
  });

  factory DepartmentModel.fromJson(Map<String, dynamic> json) {
    return DepartmentModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? 'Desconocido',
      description: json['description'] ?? 'Sin descripción',
      municipalities: json['municipalities'] ?? 0,
      // Usamos num.toInt() por si la API envía un double o un int de forma aleatoria
      surface: (json['surface'] as num?)?.toInt() ?? 0,
      population: (json['population'] as num?)?.toInt() ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'municipalities': municipalities,
      'surface': surface,
      'population': population,
    };
  }
}
