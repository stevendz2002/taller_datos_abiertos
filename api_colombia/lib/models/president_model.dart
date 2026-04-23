class PresidentModel {
  final int id;
  final String image;
  final String name;
  final String lastName;
  final String startPeriodDate;
  final String endPeriodDate;
  final String politicalParty;
  final String description;

  PresidentModel({
    required this.id,
    required this.image,
    required this.name,
    required this.lastName,
    required this.startPeriodDate,
    required this.endPeriodDate,
    required this.politicalParty,
    required this.description,
  });

  factory PresidentModel.fromJson(Map<String, dynamic> json) {
    return PresidentModel(
      id: json['id'] ?? 0,
      image: json['image'] ?? '',
      name: json['name'] ?? 'Desconocido',
      lastName: json['lastName'] ?? '',
      startPeriodDate: json['startPeriodDate'] ?? 'N/A',
      endPeriodDate: json['endPeriodDate'] ?? 'N/A',
      politicalParty: json['politicalParty'] ?? 'Independiente',
      description: json['description'] ?? 'Sin descripción',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'image': image,
      'name': name,
      'lastName': lastName,
      'startPeriodDate': startPeriodDate,
      'endPeriodDate': endPeriodDate,
      'politicalParty': politicalParty,
      'description': description,
    };
  }
}
