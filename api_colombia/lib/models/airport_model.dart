class AirportModel {
  final int id;
  final String name;
  final String iataCode;
  final String oaciCode;
  final String type;
  final int departmentId;

  AirportModel({
    required this.id,
    required this.name,
    required this.iataCode,
    required this.oaciCode,
    required this.type,
    required this.departmentId,
  });

  factory AirportModel.fromJson(Map<String, dynamic> json) {
    return AirportModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? 'Sin nombre',
      iataCode: json['iataCode'] ?? 'N/A',
      oaciCode: json['oaciCode'] ?? 'N/A',
      type: json['type'] ?? 'Desconocido',
      // Soporta el error ortográfico de la API
      departmentId: json['deparmentId'] ?? json['departmentId'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'iataCode': iataCode,
      'oaciCode': oaciCode,
      'type': type,
      'departmentId': departmentId,
    };
  }
}
