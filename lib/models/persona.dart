class Persona {
  final String? id;  // El ID puede ser nulo
  final String nombre;
  final String apellido;
  final String telefono;

  Persona({
    this.id,             // El id ahora puede ser opcional
    required this.nombre,
    required this.apellido,
    required this.telefono,
  });

  factory Persona.fromJson(Map<String, dynamic> json) {
    return Persona(
      id: json['_id'],    // Aquí el id es opcional
      nombre: json['nombre'],
      apellido: json['apellido'],
      telefono: json['telefono'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nombre': nombre,
      'apellido': apellido,
      'telefono': telefono,
    };
  }
}
