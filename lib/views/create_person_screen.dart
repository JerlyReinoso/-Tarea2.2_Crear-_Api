import 'package:flutter/material.dart';
import '../models/persona.dart';
import '../services/api_service.dart';

class CreatePersonScreen extends StatefulWidget {
  @override
  _CreatePersonScreenState createState() => _CreatePersonScreenState();
}

class _CreatePersonScreenState extends State<CreatePersonScreen> {
  final ApiService apiService = ApiService();
  final _formKey = GlobalKey<FormState>();
  String nombre = '', apellido = '', telefono = '';

  _createPersona() async {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final persona = Persona(nombre: nombre, apellido: apellido, telefono: telefono);
      try {
        await apiService.crearPersona(persona);
        Navigator.pop(context); // Volver a la pantalla principal
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al crear persona'), backgroundColor: Colors.red),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crear Persona', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Introduce los detalles de la nueva persona',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.grey[800]),
              ),
              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Nombre',
                  labelStyle: TextStyle(color: Colors.blueAccent),
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
                validator: (value) => value!.isEmpty ? 'Campo obligatorio' : null,
                onSaved: (value) => nombre = value!,
              ),
              SizedBox(height: 15),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Apellido',
                  labelStyle: TextStyle(color: Colors.blueAccent),
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
                validator: (value) => value!.isEmpty ? 'Campo obligatorio' : null,
                onSaved: (value) => apellido = value!,
              ),
              SizedBox(height: 15),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Telefono',
                  labelStyle: TextStyle(color: Colors.blueAccent),
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
                validator: (value) => value!.isEmpty ? 'Campo obligatorio' : null,
                onSaved: (value) => telefono = value!,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _createPersona,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent, // Reemplazado primary por backgroundColor
                  padding: EdgeInsets.symmetric(vertical: 12.0),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: Text('Crear Persona', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
