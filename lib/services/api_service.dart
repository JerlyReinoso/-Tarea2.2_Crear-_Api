import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/persona.dart';

class ApiService {
  static const String apiUrl = 'http://localhost:5000/api/personas'; // Asegúrate de usar la IP correcta si no es localhost

  // Obtener todas las personas
  Future<List<Persona>> obtenerPersonas() async {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((persona) => Persona.fromJson(persona)).toList();
    } else {
      throw Exception('Error al cargar las personas');
    }
  }

  // Crear una nueva persona
  Future<Persona> crearPersona(Persona persona) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(persona.toJson()),
    );

    if (response.statusCode == 201) {
      return Persona.fromJson(json.decode(response.body));
    } else {
      throw Exception('Error al crear persona');
    }
  }

  // Actualizar persona
  Future<Persona> actualizarPersona(String id, Persona persona) async {
    final response = await http.put(
      Uri.parse('$apiUrl/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(persona.toJson()),
    );

    if (response.statusCode == 200) {
      return Persona.fromJson(json.decode(response.body));
    } else {
      throw Exception('Error al actualizar persona');
    }
  }

  // Eliminar persona
  Future<void> eliminarPersona(String id) async {
    final response = await http.delete(
      Uri.parse('$apiUrl/$id'),
    );

    if (response.statusCode != 200) {
      throw Exception('Error al eliminar persona');
    }
  }
}
