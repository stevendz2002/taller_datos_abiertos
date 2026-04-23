class TypicalDishModel {
  final int id;
  final String name;
  final String description;
  final String ingredients;
  final String imageUrl;

  TypicalDishModel({
    required this.id,
    required this.name,
    required this.description,
    required this.ingredients,
    required this.imageUrl,
  });

  factory TypicalDishModel.fromJson(Map<String, dynamic> json) {
    return TypicalDishModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? 'Desconocido',
      description: json['description'] ?? 'Sin descripción',
      ingredients: json['ingredients'] ?? 'No especificados',
      imageUrl: json['imageUrl'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'ingredients': ingredients,
      'imageUrl': imageUrl,
    };
  }
}
